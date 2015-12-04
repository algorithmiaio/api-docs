## Your First Algorithm

This portion of the docs will be a short walkthrough on how to create your first algorithm. We'll be making a classic "hello world" algorithm.

On the right side of the navigation bar near your username, you'll find a purple button that says "Add Algorithm". Naturally, this is where we'll start! By clicking this button, you'll be prompted with a dialog that allows you to give your algorithm a name and set some initial properties. You can learn more about these properties in the [Algorithm Basics](#algorithm-basics) section.

Algorithmia will now create the skeleton for your algorithm and bring you to the Edit Algorithm page. For our hello world example, we will just going to return the string "Hello" plus whatever input is passed in.

Once you have finished editing and want to run the Algorithm, go ahead and click Compile. This will save your algorithm by committing your code to your personal git and try to compile the code. After a successful compilation, you can go ahead and click the "Publish" button. If this is the first time publishing the algorithm, the dialog that pops up will let you choose who can call your algorithm and the cost of the algorithm per call. After the first version of your algorithm is published, the default for this button is to create a new revision version with no changes to the pricing. If you would like to change the pricing of the algorithm, you can create a new minor version by clicking the arrow next to the button. We do not support backwards incompatible changes at this time.

Our "Hello World" algorithm is now ready, submitted and live in the Algorithmia API. We can use the Algorithmia web console to test it out, just type "and welcome to Algorithmia". Algorithmia Web console is a specialized console that you can use to test out an algorithm by giving it the correct inputs for that algorithm. It will display the result after a successful run, or any errors that occured during the run of the algorithm.

#### Create Algorithm

From the navigation bar you can hit "Add algorithm", where you can enter an algorithm name, and select the input and output types of the algorithm. <a href="http://json.org/">JSON</a> is the most general type, but automatic parsing for a number of predefined data types are being added (currently supports <a href="http://www.ietf.org/rfc/rfc4180.txt">CSV</a>). Click the "Create" button to initialize your new algorithm. You should now be looking at the editor for your new algorithm.

#### Edit Algorithm

You algorithm can edited directly in the browser. From the browser, you can edit the source code, save your work, compile, and submit the algorithm to be available through the API.

<aside class="notice">
Note the small arrow on the left side of the web editor. Clicking this arrow will reveal the interface that enables you to add additional source files into your algorithm.
</aside>

* **Save** - Commits code to your personal git. The version code that gets assigned to the algorithm after compiling is based on this git commit.
* **Compile** - Tries to compile the source code and prints any errors to the console.
* **Publish** - If the last compilation was successful, updates the API to point to the latest version of the algorithm. Lets the algorithm developer revise the price of the algorithm per call and choose between the scale of the revision, either minor or revision versions.

If you are using the web console, some of the algorithms might time out. We arranged the algorithms that take a long time to run (e.g. most of machine learning training algorithms, speech recognition on videos that are long in duration) to write their results to data collections. If you are using cURL to run an algorithm, check the [API docs](#api-specification) to see how to avoid the long blocking wait time with an async flag.

#### Using Git

Behind the scenes, Algorithmia uses git to manage source code.
Currently git access is offline but in the future you will be able to access, modify, and submit source code to Algorithmia via git.
