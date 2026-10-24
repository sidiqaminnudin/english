#!/usr/bin/env python3
"""Offline structure check for the natural listening generator; requires no TTS key."""
import importlib.util
import json
import sys
from pathlib import Path
import xml.etree.ElementTree as ET

root=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('gen',root/'scripts'/'generate_natural_listening.py')
mod=importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
tracks,plan=mod.load_data(root)
assert len(tracks)==8 and len({t['slug'] for t in tracks})==8
for track in tracks:
    turns=mod.parse_turns(track['transcript'])
    xml=mod.build_ssml(track,plan)
    tree=ET.fromstring(xml)
    nodes=tree.findall('{http://www.w3.org/2001/10/synthesis}voice')
    assert len(nodes)==len(turns)
    assert len(track['questions'])==4
    for i,(speaker,dialogue) in enumerate(turns):
        assert nodes[i].attrib['name']==plan['voices'][track['slug']][speaker]
        assert dialogue in ''.join(nodes[i].itertext())
        if speaker!='narrator':
            assert (speaker+':') not in ''.join(nodes[i].itertext()),'Speaker label should not be spoken'
    for q in track['questions']:
        assert len(q['options'])==4 and 0<=q['correct_index']<=3
print('PASS: 8 tracks, 32 original questions, valid multi-voice SSML, no spoken speaker labels')
