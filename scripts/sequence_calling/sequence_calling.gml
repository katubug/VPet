function sequencePlay(sequenceAssetName, layer, x, y) {
  if(is_undefined(sequenceAssetName))
    throw($"SequenceAssetName argument missing")
	
  if(! variable_instance_exists(id, "_cachedSequences")) 
    _cachedSequences = {}  // store for pause/replay
	
  var existingSequence = struct_get(_cachedSequences, sequenceAssetName)
  if(! is_undefined(existingSequence)) { // play previously cached
    layer_sequence_play(existingSequence) 
  } else { // first time playing this one, spawn and cache it
    var sequenceAsset = asset_get_index(sequenceAssetName)
    var sequenceElement = layer_sequence_create(layer, x, y, sequenceAsset)
    var sequenceInstance = layer_sequence_get_instance(sequenceElement)
    if(is_undefined(sequenceInstance))
      throw($"Sequence instance {sequenceAssetName} not found or could not be created")
		
    var sequenceObjects = sequence_get_objects(sequenceAsset)
    if(is_undefined(sequenceObjects) || array_length(sequenceObjects) < 1)
      throw($"No objects found in sequence instance {sequenceAssetName}")
		
    // only overrides the first object found if multiple
    sequence_instance_override_object(sequenceInstance, sequenceObjects[0], id)
    struct_set(_cachedSequences, sequenceAssetName, sequenceElement) 
  } 
}
										
function sequencePause(sequenceAssetName) {
  if(is_undefined(sequenceAssetName))
    throw($"SequenceAssetName argument missing")
	
  if(! variable_instance_exists(id, "_cachedSequences")) 
    return(0)
		
  var existingSequence = struct_get(_cachedSequences, sequenceAssetName)
  if(! is_undefined(existingSequence)) 
    layer_sequence_pause(existingSequence)
}

//From here: https://www.reddit.com/r/gamemaker/comments/13irjww/i_wrote_a_simple_script_to_let_you_create/