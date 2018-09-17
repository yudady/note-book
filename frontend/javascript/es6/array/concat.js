/**
 * concat : 會將兩個陣列合併產生新的陣列，原陣列不改變 
 */

var alpha = ["a", "b", "c"];

var numeric = [1, 2, 3];

var numeric2 = [6, 7, 8];

var alphaNumeric = alpha.concat(numeric).concat(numeric2).concat(alpha);

console.log(alphaNumeric);


