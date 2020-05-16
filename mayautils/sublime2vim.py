import json

# NOTE: this is a sublime json to vim omnifunc converter
jsoncompletions = 'OUTPUT FROM SUBLIMEMELAUTOCOMPLETION.PY'
output = 'FILE DESTINATION'

with open(jsoncompletions) as json_file:
    data = json.load(json_file)

with open(output, 'w') as fileout:
    print('fun! MelLoad() abort', file=fileout)
    print('let c = {}', file=fileout)
    for completion in data["completions"]:
        outstr = "let c['%s'] = [{'word':'%s','kind':'f','menu':'%s', 'icase':'1'}]" %(completion['trigger'], completion['trigger'], completion['comment'])
        # print(repr(string), file=fileout)
        print(outstr.encode("unicode_escape").decode("utf-8"), file=fileout)
    print('return c', file=fileout)
    print('endfun', file=fileout)
