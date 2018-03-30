# [提供gulp解析參數功能yargs](https://www.npmjs.com/package/yargs)

## 安裝
> npm install --save-dev yargs

## github api
> https://github.com/yargs/yargs/blob/HEAD/docs/api.md#api

## Simple Example
```
#!/usr/bin/env node
const argv = require('yargs').argv
 
if (argv.ships > 3 && argv.distance < 53.5) {
  console.log('Plunder more riffiwobbles!')
} else {
  console.log('Retreat from the xupptumblers!')
}
```


```
$ ./plunder.js --ships=4 --distance=22
Plunder more riffiwobbles!
 
$ ./plunder.js --ships 12 --distance 98.7
Retreat from the xupptumblers!
```

## Complex Example
```
#!/usr/bin/env node
require('yargs') // eslint-disable-line
  .command('serve [port]', 'start the server', (yargs) => {
    yargs
      .positional('port', {
        describe: 'port to bind on',
        default: 5000
      })
  }, (argv) => {
    if (argv.verbose) console.info(`start server on :${argv.port}`)
    serve(argv.port)
  })
  .option('verbose', {
    alias: 'v',
    default: false
  })
  .argv
```