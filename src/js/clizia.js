/* Clizia  - A Comedy written by Machiavelli */

var Clizia = {};

Array.prototype.max = function() { return Math.max.apply(null, this); };
Array.prototype.min = function() { return Math.min.apply(null, this); };

/* Proper validation of an array requires a lot of checks */
var is_array = function (value) {
	return value &&
		typeof value === 'object' &&
		typeof value.length === 'number' &&
		typeof value.splice === 'function' &&
		!(value.propertyIsEnumerable('length'));
};


