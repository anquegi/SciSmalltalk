information
distanceTo: aVector
		"(c) Copyrights Didier BESSET, 2000, all rights reserved.
		 Initial code: 2/16/00 "
	| delta |
	delta := aVector - center.
	^delta * inverseCovariance * delta