"""Dependency-free coarse EJS syntax compilation and local-partial path audit."""
import pathlib,re,subprocess,tempfile
root=pathlib.Path(__file__).resolve().parents[1]/'src/views'
files=list(root.rglob('*.ejs'))
errors=[]
for f in files:
 src=f.read_text()
 matches=list(re.finditer(r'<%([=-]?)(.*?)%>',src,re.S))
 js=['function testTemplate(){let __out="";']
 pos=0
 for m in matches:
  js.append('__out += '+repr(src[pos:m.start()]).replace('\\n','\\n')+';')
  kind,code=m.group(1),m.group(2)
  if kind in ('=','-'):js.append('__out += ('+code+');')
  else:js.append(code)
  pos=m.end()
 js.append('__out += '+repr(src[pos:])+';')
 js.append('return __out; }')
 # JS literals based on Python repr are mostly compatible; replace apostrophe cases via json serialization instead.
 import json
 pos=0;js=['function testTemplate(){let __out="";']
 for m in matches:
  js.append('__out += '+json.dumps(src[pos:m.start()])+';')
  kind,code=m.group(1),m.group(2)
  js.append('__out += ('+code+');' if kind in ('=','-') else code)
  pos=m.end()
 js.append('__out += '+json.dumps(src[pos:])+';return __out;}')
 p=subprocess.run(['node','--check'],input='\n'.join(js),capture_output=True,text=True)
 if p.returncode:errors.append((f.name,p.stderr))
 for include in re.findall(r'include\([\'\"]([^\'\"]+)[\'\"]\)',src):
  target=(f.parent/(include+'.ejs')).resolve()
  if not target.exists():errors.append((f.name,'Missing include '+str(target)))
if errors:
 for f,err in errors:print('FAIL',f,err)
 raise SystemExit(1)
print(f'PASS: {len(files)} EJS templates syntax-checked and local partials resolved.')
