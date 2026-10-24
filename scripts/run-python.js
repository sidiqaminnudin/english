import {spawnSync} from 'node:child_process';
const command=process.platform==='win32'?'python':'python3';
for(const file of process.argv.slice(2)){
 const result=spawnSync(command,['-X','utf8',file],{stdio:'inherit'});
 if(result.error)throw result.error;
 if(result.status!==0)process.exit(result.status||1);
}
