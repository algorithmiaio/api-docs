## My First Algorithm

To start off, let us create a simple "Hello World" algorithm. On the navigation bar click "Add Algorithm". Here we can name our Algorithm and determine its settings. The option for Source Code determines whether you want your algorithm to be Open Source or Closed Source. You can set the ability of the algorithm to have internet access or not with the next option. This option will appear on the algorithm summary page as a permission with wording "May send your input data outside of Algorithmia" to the potential users. The last option lets you choose if you would like your algorithm to be able to call other algorithms. Since being able to call other algorithms may incur additional costs, this option will appear on the algorithm summary page as a permission with wording "May incur additional royalty and usage costs" to the potential users.

Algorithmia will now create the skeleton for your algorithm and bring you to the Edit Algorithm page. For our hello world example we are just going to return the string "Hello" plus whatever input is passed in.

@\* <img class="screenshot" src="@routes.Assets.versioned("images/FTUE/CreateAlgoHelloWorld2.png")" alt="Create Algorithm"> \*@

Once you have finished editing and want to run the Algorithm, go ahead and click Compile. This will save your algorithm by committing your code to your personal git and try to compile the code. After a successful compilation, you can go ahead and click the "Publish" button. If this is the first time publishing the algorithm, the dialog that pops up will let you choose who can call your algorithm and the cost of the algorithm per call. After the first version of your algorithm is published, the default for this button is to create a new revision version with no changes to the pricing. If you would like to change the pricing of the algorithm, you can create a new minor version by clicking the arrow next to the button. We do not support backwards incompatible changes at this time.

@\* <img class="screenshot" src="@routes.Assets.versioned("images/FTUE/CreateAlgoHelloWorld3.png")" alt="Create Algorithm"> \*@

Our "Hello World" algorithm is now ready, submitted and live in the Algorithmia API. We can use the Algorithmia web console to test it out, just type "and welcome to Algorithmia". Algorithmia Web console is a specialized console that you can use to test out an algorithm by giving it the correct inputs for that algorithm. It will display the result after a successful run, or any errors that occured during the run of the algorithm.

@\* <img class="screenshot" src="@routes.Assets.versioned("images/FTUE/CreateAlgoHelloWorld4.png")" alt="Algorithm Console"> \*@

<img class="screenshot" src="@routes.Assets.versioned("images/FTUE/helloWorldConsole.jpeg")" alt="ConsoleX">

#### Create Algorithm

From the navigation bar you can hit "Add algorithm", where you can enter an algorithm name, and select the input and output types of the algorithm. <a href="http://json.org/">JSON</a> is the most general type, but automatic parsing for a number of predefined data types are being added (currently supports <a href="http://www.ietf.org/rfc/rfc4180.txt">CSV</a>). Click the "Create" button to initialize your new algorithm. You should now be looking at the editor for your new algorithm.

#### Edit Algorithm

Algorithms can be edited directly in the browser. From the in-browser editor you can edit the source code, save you work, and when ready submit it to be made available in the [Algorithmia API](../api_v1/spec.md). Please note the small arrow on the left side of the web editor. Clicking that will reveal the interface that enables you to add additional source files into your algorithm.

* Save - Commits code to your personal git. The version code that gets assigned to the algorithm after compiling is based on this git commit.
* Compile - Tries to compile the source code and prints any errors to the console.
* Publish - If the last compilation was successful, updates the API to point to the latest version of the algorithm. Lets the algorithm developer revise the price of the algorithm per call and choose between the scale of the revision, either minor or revision versions.

If you are using the web console, some of the algorithms might time out. We arranged the algorithms that take a long time to run (e.g. most of machine learning training algorithms, speech recognition on videos that are long in duration) to write their results to <a href="#collections">data collections</a>. If you are using curl to run an algorithm, check the [API docs](../api_v1/spec.md) to see how to avoid the long blocking wait time with an async flag.

#### Using Git

Behind the scenes, Algorithmia uses git to manage source code.
Currently git access is offline but in the future you will be able to access, modify, and submit source code to Algorithmia via git.

@\*
This allows you to develop more complicated algorithms, without being limited to in-browser code editing.
Using git allows you more freedom to run your code locally, and to customize your project's code structure and dependencies.

\##Clone Algorithm

From a terminal, run the following git clone command:

```nohighlight
git clone https://git.algorithmia.com/git/{owner}/{algo}.git
```

\##Run Locally

Algorithmia uses ant as its java build system.
To run tests on your algorithm locally, run the following command from the cloned project directory to open a <em>read-eval-print-loop</em>:

```nohighlight
ant repl
```

\##Submit Algorithm

To submit an algorithm to Algorithmia, simply git push to the Algorithmia remote branch.

From a terminal, run the following git commands:

```nohighlight
git add -A
git commit -m "{Your commit message}"
git push
```

\*@
