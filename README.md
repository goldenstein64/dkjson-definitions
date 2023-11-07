# dkjson Definitions

Definition files for [dkjson by David Kolf](http://dkolf.de/src/dkjson-lua.fsl). The annotations have been manually re-written directly from the [docs](http://dkolf.de/src/dkjson-lua.fsl/wiki?name=Documentation) to be parsable by the LSP.

## Usage

For manual installation, add these settings to your `settings.json` file.

```jsonc
// settings.json
{
	"Lua.workspace.library": [
		// path to wherever this repo was cloned to
		"path/to/this/repo/library"
		// e.g. on Windows, "$USERPROFILE/Documents/LuaEnvironments/dkjson/library"
	]
}
```

## Types

Every type is stored in one file, namely `library/dkjson.lua`.

The types provided by this library are, exhaustively:

* Classes, given as `dkjson.[CLASS NAME]`. Every class is listed below:
   * `dkjson`
	 * `dkjson.state`
	 * `dkjson.null`, used as an opaque symbol type

* Aliases, given as `dkjson.[ALIAS NAME]`. Every alias is listed below:
	 * `dkjson.exception`
   * `dkjson.exception.reason`
