import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false,
  'b': false,
  'c': false,
  'd': false,
  'e': false,
  'f': false,
  'g1': false,
  'g2': false,
  'h': false,
  'i': false,
  'j': false,
  'k': false,
  'l': false,
  'm': false,
  'dp': false
};


class FourteenSegmentDisplay extends NSegmentDisplay {

  FourteenSegmentDisplay({
      Key? key,
      required Map<String, bool> segments,
      SegmentDisplayType? type,
      bool readOnly = false,
      void Function(Map<String, bool>)? onChanged})
      : super(
            key: key,
            initialSegments: _INITIAL_SEGMENTS,
            segments: segments,
            readOnly: readOnly,
            onChanged: onChanged,
            type: (Variants14Segment.contains(type) ? type : null)  ?? SegmentDisplayType.FOURTEEN);
}
