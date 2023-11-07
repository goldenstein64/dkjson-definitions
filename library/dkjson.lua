---@meta

---In the default configuration this module writes no global values, not even the module table. Import it using
---
---```lua
---json = require("dkjson")
---```
---
---In environments where require or a similiar function are not available and
---you cannot receive the return value of the module, you can set the option
---`register_global_module_table` to `true`. The module table will then be
---saved in the global variable with the name given by the option
---`global_module_name`.
---@class dkjson
local json = {}

---@alias dkjson.exception.reason
---| "reference cycle"
---| "custom encoder failed"
---| "unsupported type"

---@alias dkjson.exception fun(reason: dkjson.exception.reason, value: unknown, state: dkjson.state, defaultmessage: string): (pass: true|string?, msg: string?)

---@class dkjson.state
---When `indent` (a boolean) is set, the created string will contain newlines
---and indentations. Otherwise it will be one long line.
---@field indent? boolean
---`keyorder` is an array to specify the ordering of keys in the encoded
---output. If an object has keys which are not in this array they are written
---after the sorted keys.
---@field keyorder? string[]
---This is the initial level of indentation used when `indent` is set. For each
---level two spaces are added. When absent it is set to 0.
---@field level? integer
---`buffer` is an array to store the strings for the result so they can be
---concatenated at once. When it isn't given, the encode function will create
---it temporary and will return the concatenated result.
---
---When `state.buffer` was set, the return value will be `true` on success.
---Without `state.buffer` the return value will be a string.
---@field buffer? string[]
---When `bufferlen` is set, it has to be the index of the last element of
---`buffer`.
---@field bufferlen? integer
---`tables` is a set to detect reference cycles. It is created temporary when
---absent. Every table that is currently processed is used as key, the value is
---`true`.
---@field tables? { [table]: true? }
---When `exception` is given, it will be called whenever the encoder cannot
---encode a given value.
---
---The parameters are `reason`, `value`, `state` and `defaultmessage`. `reason`
---is either `"reference cycle"`, `"custom encoder failed"` or
---`"unsupported type"`. `value` is the original value that caused the
---exception, `state` is this state table, `defaultmessage` is the message of
---the error that would usually be raised.
---
---You can either return `true` and add directly to the buffer or you can
---return the string directly. To keep raising an error return `nil` and the
---desired error message.
---
---An example implementation for an exception function is given in
---`json.encodeexception`.
---@field exception? dkjson.exception

---Create a string representing the object. `Object` can be a table, a string,
---a number, a boolean, `nil`, `json.null` or any object with a function
---`__tojson` in its metatable. A table can only use strings and numbers as
---keys and its values have to be valid objects as well. It raises an error for
---any invalid data types or reference cycles.
---
---When `state.buffer` was set, the return value will be `true` on success.
---Without `state.buffer` the return value will be a string.
---@param object unknown
---@param state dkjson.state
---@return string | true
function json.encode(object, state) end

---@param object unknown
---@return string
---@nodiscard
function json.encode(object) end

---Decode `string` starting at `position` or at 1 if position was omitted.
---
---`null` is an optional value to be returned for null values. The default is
---`nil`, but you could set it to `json.null` or any other value.
---
---Two metatables are created. Every array or object that is decoded gets a
---metatable with the `__jsontype` field set to either `array` or `object`. If
---you want to provide your own metatables use the syntax
---
---```lua
---json.decode(string, position, null, objectmeta, arraymeta)
---```
---
---To prevent the assigning of metatables pass `nil`:
---
---```lua
---json.decode(string, position, null, nil)
---```
---@param string string
---@param position? integer
---@param null? unknown
---@return unknown? object
---@return integer position -- the position of the next character that doesn't belong to the object
---@return string? err -- in case of errors an error message
function json.decode(string, position, null) end

---You can use this value for setting explicit `null` values.
---@class dkjson.null
json.null = {}

json.version = "dkjson 2.6"

---Quote a UTF-8 string and escape critical characters using JSON escape
---sequences. This function is only necessary when you build your own
---`__tojson` functions.
---@param string string
---@return string
---@nodiscard
function json.quotestring(string) end

---When `state.indent` is set, add a newline to `state.buffer` and spaces
---according to `state.level`.
---@param state dkjson.state
function json.addnewline(state) end

---This function can be used as a value to the `exception` option. Instead of
---raising an error this function encodes the error message as a string. This
---can help to debug malformed input data.
---
---```lua
---x = json.decode(value, { exception = json.encodeexception })
---```
---@type dkjson.exception
function json.encodeexception(reason, value, state, defaultmessage) end

---When the local configuration variable always_use_lpeg is set, this module
---tries to load LPeg to replace the decode function. The speed increase is
---significant. You can get the LPeg module at
---http://www.inf.puc-rio.br/~roberto/lpeg/.
---
---Require the LPeg module and return a copy of the module table where the
---decode function was replaced by a version that uses LPeg:
---
---```lua
---json = require "dkjson".use_lpeg()
---```
---
---Without the configuration to always use LPEG the original module table is
---unchanged and still available by calls to
---
---```lua
---json = require "dkjson"
---```
---@return dkjson
function json.use_lpeg() end

---This variable is set to `true` in the copy of the module table that uses
---LPeg support.
---@type true | nil
json.using_lpeg = nil

return json
