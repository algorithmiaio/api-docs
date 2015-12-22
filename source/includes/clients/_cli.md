
## CLI

Algorithmia CLI is a cross-platform tool for interfacing with algorithms and the Algorithmia Data API.

### Installing the Algorithmia CLI

> Debian/Ubuntu

```
curl -L https://github.com/algorithmiaio/algorithmia-cli/releases/download/v1.0.0-beta.2/algorithmia_1.0.0-beta.2_amd64.deb | sudo dpkg -i
```

> Arch

```
aura -A algorithmia-bin
```

> OSX

```
curl -L https://github.com/algorithmiaio/algorithmia-cli/releases/download/v1.0.0-beta.2/algorithmia_osx.tar.gz | tar -xz
```

> We recommend putting it within your `PATH` with the following command:

```
sudo mv algo /usr/local/bin/
```

The latest releases & changelog can be found [here](https://github.com/algorithmiaio/algorithmia-cli/releases/latest).

**Debian/Ubuntu**

For our Debian/Ubuntu users, a `.deb` package is available for installation with `dpkg`. Simply run the following:

**Arch**

Arch packages available on the AUR as [algorithmia-bin](https://aur4.archlinux.org/packages/algorithmia-bin/) and [algorithmia-git](https://aur4.archlinux.org/packages/algorithmia-git/). Use your favorite AUR helper (e.g. `aura`):

**OSX**

Simply download and extract the OSX tarball.


**Windows (64-bit)**

Install [OpenSSL for Windows](https://slproweb.com/products/Win32OpenSSL.html).
Download and extract the [latest Windows zip file](https://github.com/algorithmiaio/algorithmia-cli/releases/download/v1.0.0-beta.2/algorithmia_win64.zip). Again, we recommend putting it within your `PATH`.


### Configure Authentication

```
$ algo auth
Configuring authentication for 'default' profile
Enter API Key (prefixed with 'sim'):
Profile is ready to use. Test with 'algo ls'
```

In order to make calls with the CLI, you'll need to configure the authentication with an API key. If you don't already have an API key, get started by signing up for an account at [Algorithmia.com](https://algorithmia.com). Once you've completed the sign up process, copy the API key from your account dashboard.

Begin the configuration process by running the command `algo auth`.
You will see an interactive prompt to guide you through setting up a default profile.

See [Using multiple profiles](#using-multiple-profiles) for instructions on how to set authenticate and use more than one profile with the Algorithmia CLI tool.

### Usage

```
$ algo run kenny/factor -d 19635
[3,5,7,11,17]
```

> Add the option `--response-body` to see the full JSON response:

```
$ algo run kenny/factor -d 19635 --response-body
{"result":[3,5,7,11,17],"metadata":{"content_type":"json","duration":0.001427314}}
```

To call an algorithm from the CLI, use the command syntax: `algo run`, followed by the algorithm’s username and algorithm name, the data options, and finally the input. In the right pane, you'll see a basic example calling the [Factor algorithm](https://algorithmia.com/algorithms/kenny/Factor).

Run `algo run --help` to see more command options or view the following [Options](#options) section.

#### Options

##### Input Data Options
There are several options for specifying the type and source of input data. The Algorithmia CLI supports JSON, text, and binary data, as well as an option to auto-detect the data type.

| Option Flag               | Description |
| :-----------------------  | :--------------- |
| -d, --data DATA           | If the data parses as JSON, assume JSON, else if the data is valid UTF-8, assume text, else assume binary |
| -D, --data-file FILE      | Same as --data, but the input data is read from a file |
| -j, --json DATA           | Algorithm input data as JSON (application/json) |
|-J, --json-file FILE       | Same as --json, but the input data is read from a file |
| -t, --text DATA           | Algorithm input data as text (text/plain) |
| -T, --text-file FILE      | Same as --text, but the input data is read from a file |
| -b, --binary DATA         | Algorithm input data as binary (application/octet-stream) |
| -B, --binary-file FILE    | Same as --data, but the input data is read from a file |

##### Output Options

The algorithm result is printed to STDOUT by default. Additional notices may be printed to STDERR. If you'd like to output the result to a file, use the output option flag followed by a filename:

```bash
$ algo run kenny/factor -d 17 --output results.txt
```

> Examples:

```bash
$ algo kenny/factor/0.1.0 -t '79'                   Run algorithm with specified version & data input as text
$ algo anowell/Dijkstra -J routes.json              Run algorithm with file input
$ algo anowell/Dijkstra -J - < routes.json          Same as above but using STDIN
$ algo opencv/SmartThumbnail -B in.png -o out.png   Runs algorithm with binary data input
$ algo run kenny/factor -d 17 --timeout 2           Runs algorithm with a timeout of 2 seconds
```

| Option Flag     | Description |
| :------------   |:--------------- |
| --debug         | Print algorithm's STDOUT (author-only) |
| --response-body | Print HTTP response body (replaces result) |
|  --response     | Print full HTTP response including headers (replaces result) |
| -s, --silence   | Suppress any output not explicitly requested (except result) |
| -m, --meta      | Print human-readable selection of metadata (e.g. duration) |
| -o, --output FILE |  Print result to a file, implies --meta |

##### Other Options

| Option Flag     | Description |
| :------------   |:--------------- |
| --timeout SECONDS | Sets algorithm timeout


### CLI & The Data API
#### Examples of the Algorithmia Data API usage:

> Create a data directory:

```
$ algo mkdir .my/cuteAnimals

Created directory data://.my/cuteAnimals
```

> Copy a file from your local directory to the new data directory:

```
$ algo cp chubby_kittens.jpg data://.my/cuteAnimals

Uploaded data://.my/cuteAnimals/chubby_kittens.jpg
```

Use the Algorithmia CLI to interact with the Algorithmia Data API. You can use the CLI to create and manage your data directories.

**Data commands include:**

| Command   | Description |
| :------------   |:--------------- |
| ls |  List contents of a data directory |
| mkdir | Create a data directory |
| rmdir | Delete a data directory |
| rm | Remove a file from a data directory |
| cp | Copy file(s) to or from a data directory |
| cat | Concatenate & print file(s) in a directory |


### Using multiple profiles

#### Add additional profiles

With the Algorithmia CLI, you can configure multiple custom profiles to use. To add a new profile, you will run through the same interactive prompt--simply add a profile name to the command to add a new profile.

```
$ algo auth second_user
Configuring authentication for 'second_user' profile
Enter API Key (prefixed with 'sim'):
Profile is ready to use. Test with 'algo ls'
```

When you re-run the `algo ls` command, you should now see both profiles. For more information, see the auth command help with `algo auth --help`.

#### Using profiles in commands

When running commands, the Algorithmia CLI will use the default profile unless otherwise specified with the `--profile <profile>` option. See the following example:

```bash
$ algo run kenny/factor -d 17 --profile second_user
[17]
```