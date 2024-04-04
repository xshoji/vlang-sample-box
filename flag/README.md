# flag

```
$ v run main.v
------
ERROR: Not enough required parameters.
------
flag_example_tool v0.0.1
-----------------------------------------------
Usage: flag_example_tool [options] [ARGS]

Description: This tool is only designed to show how the flag lib is working

The arguments should be at most 2 in number.

Options:
  -f, --file-size <int>     [required] file size
  -i, --item-name <string>  [required] item name
  -c, --count <int>         [optional] count ( default: 0o123 )
  -r, --ratio <float>       [optional] ratio ( default 1.0 )
  -t, --title <string>      [optional] title
  -g, --global              [optional] boolean type flag. --global will set it to true.
  -p, --person-names <multiple strings>
                            [optional] multiple string values
```
