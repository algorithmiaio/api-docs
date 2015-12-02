# Bounties

The bounty system is designed to allow users to specify problems with concrete input/output so that subject matter experts can provide tailored black-box solutions. More specifically, solutions to problems that an expert can understand or can work out reasonably from existing knowledge. For example

Clearly defined transformations on structured data
Obscure but well-defined statistical metrics on real-valued data
Extracting keywords for each document from a set of text documents
It is not a good match for problems that are not clearly algorithmically definable or whose solutions are not well understood, for instance:

Tasks that require substantial human intervention/client side work - e.g. 3-D animation
Research-level problems that not even experts know how to solve
The best bounties are things you don’t quite know how to solve, but you are reasonably confident that a subject expert probably knows.

Even after deciding on a bounty, writing it effectively requires some thought. Think of it as a design specification - the more complete, the better. There are roughly three levels to consider, and their relative importance will differ depending upon your purpose.

Specify the problem - this can range from something as mundane as converting between file formats to something as abstract as a combinatorial optimization problem. Describe it briefly and include any relevant links to papers or wikipedia - this isn’t academia and we won’t judge you. Also, provide example data if you can. At minimum describe or provide a toy instance, try to provide real instances if you can. To make this easier, you can put files in the DataAPI and make them publicly readable.
Specify the interface - sometimes this is obvious given the problem, but in many cases, some input and output formats will be more useful than others. Usually this will just be something standard, like a list of strings or an array of ints, etc. In other cases a custom class is easier. If the latter, see our docs on using custom classes (this is just for Java at the moment, but it will give you an idea) and provide a definition of the class in the bounty.
Specify the Algorithm - this is obvious if you want a particular algorithm, though sometimes you have no idea what the algorithm should be, or you don’t care. If it’s a hard problem though, your odds of getting a successful submission quickly will be improved if you provide ideas of what you think the algorithm might be, with links to whatever resources might help an algorithm developer.
One consideration that will have some bearing on how you do all of the above is how you will evaluate submissions. Provide test cases if you can, ideally using publicly readable files in the DataAPI as described above.

## Pledging to a Bounty

In order to incentivize algorithm developers to develop an algorithm that fulfills your bounty, you can pledge between $10 and $10,000 USD to the solution. Algorithmia collects a 20% fee when you pledge a bounty. Bounties may be pledged in USD, Algorithmia credits, or both.

As the author of the bounty, you will have the opportunity to review submitted solutions and accept or reject them according to the requirements described in your bounty. For solutions that you reject, you will need to adequately explain why they don't meet the requirements of your bounty. Pledging a bounty will start a 60-day countdown on your bounties page, and if your bounty is not fulfilled within those 60 days, you will have the choice of receiving a refund or renewing your bounty pledge.

## Fulfilling a Bounty

To fulfill a bounty, make sure you have published the algorithm publically (not necessarily open source). Then, go to the bounty page and click the “Fulfill Bounty” button. A dialog box containing the Algorithmia Bounty Terms and Agreement will appear. read the agreement, and if you find it acceptable, select the algorithm from the drop-down menu at the bottom and click the “I agree to terms and submit algorithm for review” button. The bounty poster will have 30 days to review the algorithm, give you feedback, and ultimately pay the bounty out if the algorithm is accepted.