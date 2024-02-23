# Define height and weight vectors
height <- c(59,60,61,58,67,72,70)
weight <- c(150,140,180,220,160,140,130)

# Define variable a
a <- 150

# STEP 1: CALCULATING MEANS
# 1) Compute the	average	height
avgHeight <- mean(height)

# 2) Compute the	average	weight
avgWeight <- mean(weight)

# 3) Calculate	the	length	of	the	vector	'height'	and	'weight'
lenHeight <- length(height)
lenWeight <- length(weight)

# 4) Calculate	the	sum	of	the	heights
sumHeight <- sum(height)
sumWeight <- sum(weight)

# 5) Compute	the	average of	both	height	and	weight
avgHeight2 <- sumHeight/lenHeight
avgWeight2 <- sumWeight/lenWeight

# compare avarages, check if both are same/equal
sameMeanHeight <- avgHeight2 == avgHeight
sameMeanWeight <- avgWeight2 == avgWeight


# STEP 2: USING MAX/MIN FUNCTIONS
# 6 Compute	the	max	height,	store	the	result	in	'maxH'
maxH <- max(height)

# 7 Compute	the	min	weight,	store	the	results	in	'minW'
minW <- min(weight)

# STEP 3: VECTOR MATH
# 8 Create	a	new	vector,	which	is	the	weight	+	5
weight2 <- c(weight + 5)

# 9 Compute	the	weight/height	for	each	person,	using	the	new	weight	just created
weightHeight <- c(weight2/height)



# STEP 4: Using conditional if statements
# 10 	if	max	height is	greater	than	60	(output	"yes"	or	"no")
if (maxH > 60) "yes" else "no"

# 11 	if	min	weight is	greater	than	the	variable	'a'	(output	"yes"	or	
#     "no")
if (minW > a) "yes" else "no"
