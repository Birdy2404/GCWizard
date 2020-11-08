import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/kitchen.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/recipe.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chefException.dart';

// 10 items (0-9)  26 items (a-z)  5 items (.,;!?) > 41 items
// number: dry        g kg pinch(es)
// character: liquid  ml l dash(es)
// indefinite: cup(s) teaspoon(s) tablespoon(s) => liquefy or
//['', '']
final itemList = [
  ['g','flour'], ['g', 'white sugar'], ['pinch', 'salt'], ['pinches', 'baking soda'], ['g', 'butter'],
  ['', 'vanilla bean'], ['tablespoon', 'brown sugar'], ['pinch', 'pepper'], ['', 'eggs'], ['g', 'haricot beans'],
  ['g', 'red salmon'], ['ml', 'milk'], ['ml', 'water'], ['ml', 'oil'], ['ml', 'water'],
  ['drips', 'liquid vanilla'], ['dashes', 'lemon juice'], ['teaspoon', 'powdered-sugar'], ['', 'almonds'], ['', 'onions'],
  ['', 'garlic cloves'], ['', 'cinnamon'], ['', 'egg yolk'], ['', 'egg white'], ['pinches', 'kummel'],
  ['pinches', 'aniseed'], ['ml', 'amaretto'], ['tablespoon', 'espresso'], ['', 'cream'], ['', 'sour cream'],
  ['', 'cream cheese'], ['cups', 'cheese'], ['ml', 'white wine'], ['ml', 'red wine'], ['gr', 'pumpkin'],
  ['g', 'cucumber'], ['g', 'potatoes'], ['gr', 'sweet potatoes'], ['g', 'apple pieces '], ['', 'shrimps'],
  ['g', 'guacamole'], ['g', 'wholemeal flour'], ['g', 'tofu'], ['teaspoon', 'chili'], ['teaspoon', 'curry'],
  ['dashes', 'tabasco'], ['g', 'mustard'], ['tablespoon', 'jam'], ['g', 'mixed fruits'], ['dashes', 'calvados'],
	['g', 'zucchini'], ['g', 'lard'], ['table spoon', 'corn starch'], ['slices', 'bread'], ['g', 'bacon'],
	['g', 'dark chocolate'],['g', 'milk chocolate'], ['ml', 'double cream'], ['g', 'cocoa powder'], ['ml', 'beaten eggs'],
	['g', 'peas'], ['g', 'carrots'], ['g', 'raisins'],['teaspoon', 'mexican spices'],['', 'banana']
];

String generateChef(String title, String remark, String time, String temperature, String outputToGenerate){
  String output ="";
  var ingredients;
  List<String> methodList = new List<String>();
  List<String> ingredientList = new List<String>();
  Map<int, String> amount = new Map<int, String>();
  Map<String, String> ingredientListed = new Map<String, String>();
  int value = 0;
  var item;

  Random random = new Random();

  ingredients = outputToGenerate.split('').reversed;
  ingredients.forEach((element) {
    value = element.codeUnitAt(0);
    if (amount[value] == null) {
      item = itemList.elementAt(random.nextInt(itemList.length));
      while(ingredientListed[item.elementAt(1)] != null) {
        item = itemList.elementAt(random.nextInt(itemList.length));
      }
      ingredientListed[item.elementAt(1)] = item.elementAt(1);
      ingredientList.add(value.toString() + ' ' + item.elementAt(0) + ' ' + item.elementAt(1));
      amount[value] = item.elementAt(1);
      methodList.add('Put ' + amount[value] + ' into the mixing bowl.');
    } else {
      methodList.add('Put ' + amount[value] + ' into the mixing bowl.');
    }
  });

  output = output + title + ' \n';
  output = output + '\n';
  output = output + remark + ' \n';
  output = output + '\n';
  output = output + 'Ingredients.' + ' \n';
  output = output + ingredientList.join('\n') + '\n';
  output = output + '\n';
  if (int.tryParse(time) != null) {
    output = output + 'Cooking time: ' + time + ' minutes.' + '\n';
    output = output + '\n';
  }
  if (int.tryParse(temperature) != null) {
    output = output + 'Pre-heat oven to ' + temperature + ' degrees Celsius.' + '\n';
    output = output + '\n';
  }
  output = output + 'Method.' + ' \n';
  output = output + methodList.join('\n') + '\n';
  output = output + 'Liquefy contents of the mixing bowl.' + '\n';
  output = output + 'Pour contents of the mixing bowl into the baking dish.' + ' \n';
  output = output + '\n';
  output = output + 'Serves 1.' + '\n';
  return output;
}


bool isValid(String input){
	bool flag = true;
	if (input == null || input == '')
		return true;
	List<String> numbers = input.split(' ');
	numbers.forEach((element) {
		if (int.tryParse(element) == null) {
			flag = false;
		}
	});
	return flag;
}


List<String> interpretChef(String recipe, String input) {
	if (recipe == null || recipe == '')
		return new List<String>();

  return decodeChefLanguage(recipe, input);
}


List<String> decodeChefLanguage(String recipe, additionalIngredients)  { //throws Exception
	Chef interpreter = Chef(recipe);
	if (interpreter.valid) {
		interpreter.bake(additionalIngredients);
		if (interpreter.valid)
			return interpreter.meal;
		else
			return interpreter.error;
	} else
		return interpreter.error;
}


class Chef {

	Map<String, Recipe> recipes;
	Recipe mainrecipe;
	List<String> error;
	bool valid;
	List<String> meal;

	Chef(String readRecipe) {
		this.meal = new List<String>();		valid = true;
		error = new List<String>();
		recipes = new Map<String, Recipe>();
		int progress = 0;
		Recipe r = null;
		String title = '';
		readRecipe.split("\n\n")
			.forEach((line) {
				if (line.startsWith("ingredients")) {
					if (progress > 3) {
						valid = false;
						error.add('chef_error_recipe_structural');
						error.add('chef_error_recipe_read_unexpected');
						error.add(_progressToExpected(2));
						error.add('chef_error_recipe_expecting');
						error.add(_progressToExpected(progress));
						return '';
					}
						//throw new ChefException(ChefException.STRUCTURAL,
						//		"Read unexpected " + _progressToExpected(2) + ". Expecting " + _progressToExpected(progress));
					progress = 3;
					r.setIngredients(line);
				} else if (line.startsWith("cooking time")) {
					if (progress > 4) {
						valid = false;
						error.add('chef_error_recipe_structural');
						error.add('chef_error_recipe_read_unexpected');
						error.add(_progressToExpected(3));
						error.add('chef_error_recipe_expecting');
						error.add(_progressToExpected(progress));
						return '';
					}
						//throw new ChefException(ChefException.STRUCTURAL,
						//		"Read unexpected " + _progressToExpected(3) + ". Expecting " + _progressToExpected(progress));
					progress = 4;
					r.setCookingTime(line);
				} else if (line.startsWith("pre-heat oven")) {
					if (progress > 5) {
						valid = false;
						error.add('chef_error_recipe_structural');
						error.add('chef_error_recipe_read_unexpected');
						error.add(_progressToExpected(4));
						error.add('chef_error_recipe_expecting');
						error.add(_progressToExpected(progress));
						return '';
					}
						//throw new ChefException(ChefException.STRUCTURAL,
						//		"Read unexpected " + _progressToExpected(4) + ". Expecting " + _progressToExpected(progress));
					progress = 5;
					r.setOvenTemp(line);
				} else if (line.startsWith("method")) {
					if (progress > 5){
						valid = false;
						error.add('chef_error_recipe_structural');
						error.add('chef_error_recipe_read_unexpected');
						error.add(_progressToExpected(5));
						error.add('chef_error_recipe_expecting');
						error.add(_progressToExpected(progress));
						return '';
					}
						//throw new ChefException(ChefException.STRUCTURAL,
						//		"Read unexpected " + _progressToExpected(5) + ". Expecting " + _progressToExpected(progress));
					progress = 6;
					r.setMethod(line);
				} else if (line.startsWith("serves")) {
					if (progress != 6) {
						valid = false;
						error.add('chef_error_recipe_structural');
						error.add('chef_error_recipe_read_unexpected');
						error.add(_progressToExpected(6));
						error.add('chef_error_recipe_expecting');
						error.add(_progressToExpected(progress));
						return '';
					}
						//throw new ChefException(ChefException.STRUCTURAL,
						//		"Read unexpected " + _progressToExpected(6) + ". Expecting " + _progressToExpected(progress));
					progress = 0;
					r.setServes(line);
				} else {
					if (progress == 0 || progress >= 6) {
						title = _parseTitle(line);
						r = new Recipe(title);
						if (mainrecipe == null)
							mainrecipe = r;
						progress = 1;
						recipes.addAll({title : r});
					} else if (progress == 1) {
						progress = 2;
						r.setComments(line);
					} else {
						valid = false;
						error.add('chef_error_recipe_structural');
						error.add('chef_error_recipe_read_unexpected_comments_title');
						error.add(_progressToExpected(progress));
						error.add('chef_hint_recipe_hint');
						error.add(_structHint(progress));
						return '';
						//throw new ChefException(ChefException.STRUCTURAL,
						//		"Read unexpected comments/title. Expecting " + _progressToExpected(progress) + " Hint:" + _structHint(progress));
					}
				}
		});
		recipes.addAll({_parseTitle(title): r});
		if (mainrecipe == null) {
			valid = false;
			error.add('chef_error_recipe_structural');
			error.add('chef_error_recipe_empty_mising_title');
			return;
		}
			//throw new ChefException(
			//		ChefException.STRUCTURAL, "Recipe empty or title missing!");
	}


	String _parseTitle(String title) {
		if (title.endsWith('.')) {
			title = title.substring(0, title.length - 1);
		}
		return title.toLowerCase();
	}

	String _structHint(int progress) {
		switch (progress) {
			case 2 :	return 'chef_hint_recipe_ingredients'; //"did you specify 'Ingredients.' above the ingredient list?";
			case 3 :	return 'chef_hint_recipe_methods'; //"did you specify 'Methods.' above the methods?";
		}
		return "chef_hint_no_hint_available";
	}

	String _progressToExpected(int progress) {
		switch (progress) {
			case 0 :	return 'chef_error_recipe_title';
			case 1 :	return 'chef_error_recipe_comments';
			case 2 :	return 'chef_error_recipe_ingredient_list';
			case 3 :	return 'chef_error_recipe_cooking_time';
			case 4 :	return 'chef_error_recipe_oven_temperature';
			case 5 :	return 'chef_error_recipe_methods';
			case 6 :	return 'chef_error_recipe_serve_amount';
		}
		return null;
	}

	void bake(String additionalIngredients) {
		Kitchen k = new Kitchen(this.recipes, this.mainrecipe, null, null);
		if (k.valid)
			k.cook(additionalIngredients);
    this.valid = k.valid;
    this.meal = k.meal;
    this.error = k.error;
	}
}
