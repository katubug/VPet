// Generate random amounts for each stat
var _e = irandom(10);
var _j = irandom(10);
var _n = irandom(10);
var _s = irandom(10);

// Apply the random boosts
global.pet.enthusiasm = (global.pet.enthusiasm + _e);
global.pet.joy = (global.pet.joy + _j);
global.pet.nonsense = (global.pet.nonsense + _n);
global.pet.selfesteem = (global.pet.selfesteem + _s);

// Log each change to stat history so the dev panel shows the source
stat_history_log("enthusiasm", "dev_random", _e);
stat_history_log("joy", "dev_random", _j);
stat_history_log("nonsense", "dev_random", _n);
stat_history_log("selfesteem", "dev_random", _s);

show_debug_message($"Now adding random stats. E: {global.pet.enthusiasm}, J: {global.pet.joy}, N: {global.pet.nonsense}, S: {global.pet.selfesteem}")