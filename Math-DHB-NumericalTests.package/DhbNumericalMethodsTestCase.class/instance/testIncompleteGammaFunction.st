iterative algorithms
testIncompleteGammaFunction

	| function |
	function := DhbIncompleteGammaFunction shape: 2.
	self should: [ ( (function value: 2) - 0.59399414981) abs < 0.00000000001].