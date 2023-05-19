# k6

## How to build k6

If you want to use k6 with additional feature, you have to build your own k6 binary. 
In this case, xk6 can assist you. [xk6](https://github.com/grafana/xk6). is build tool for k6.
It allows you to build a customized k6 binary with the desired features.

### Build with xk6

install xk6 first.

```shell
go install go.k6.io/xk6/cmd/xk6@latest
```

build k6 using xk6.

```
xk6 build [<k6_version>]
[--output <file>]
[--with <module[@version][=replacement]>...]
[--replace <module=replacement>...]
```

Examples:
```shell
xk6 build \
    --with github.com/grafana/xk6-browser
```
```shell
xk6 build v0.35.0 \
    --with github.com/grafana/xk6-browser@v0.1.1
```
```shell
xk6 build \
    --with github.com/grafana/xk6-browser=../../my-fork
```
```shell
xk6 build \
    --with github.com/grafana/xk6-browser=.
```
```shell
xk6 build \
    --with github.com/grafana/xk6-browser@v0.1.1=../../my-fork
```

### Build using conatainer
You can use a container image to build k6 artifacts. There is no need to install xk6 or any other additional resources for the process.

#### Linux
```shell
docker run --rm -it -u "$(id -u):$(id -g)" -v "${PWD}:/xk6" grafana/xk6 build v0.43.1 \
  --with github.com/mostafa/xk6-kafka@v0.17.0 \
  --with github.com/grafana/xk6-output-influxdb@v0.3.0
```

#### MacOS
```shell
docker run --rm -it -e GOOS=darwin -u "$(id -u):$(id -g)" -v "${PWD}:/xk6" \
  grafana/xk6 build v0.43.1 \
  --with github.com/mostafa/xk6-kafka@v0.17.0 \
  --with github.com/grafana/xk6-output-influxdb@v0.3.0
```

#### Windows
For PowerShell:
```shell
docker run --rm -it -e GOOS=windows -u "$(id -u):$(id -g)" -v "${PWD}:/xk6" `
  grafana/xk6 build v0.43.1 --output k6.exe `
  --with github.com/mostafa/xk6-kafka@v0.17.0 `
  --with github.com/grafana/xk6-output-influxdb@v0.3.0
```

For cmd.exe:
```shell
docker run --rm -it -e GOOS=windows -v "%cd%:/xk6" ^
  grafana/xk6 build v0.43.1 --output k6.exe ^
  --with github.com/mostafa/xk6-kafka@v0.17.0 ^
  --with github.com/grafana/xk6-output-influxdb@v0.3.0
```


## Build Container image for k6 runner
This image used as a golden image. After build this image, After building this image, you need to integrate your test code into it. 

Reference: https://github.com/grafana/xk6-output-influxdb/blob/main/Dockerfile

## Extensions

### k6 output prometheus

Reference: https://github.com/grafana/xk6-output-prometheus-remote

### k6 output influxdb

Reference: https://github.com/grafana/xk6-output-influxdb

### k6 custom summary reporter
It doesn't need to be built into a k6 binary, but it must be imported in summary test code. 

Reference: https://github.com/benc-uk/k6-reporter


# Test Code

## Configure project

Initiate node project.
```shell
npm init -y
```

Install essential libraries.
```shell
npm install --save-dev \
    webpack \
    webpack-cli \
    k6 \
    babel-loader \
    @babel/core \
    @babel/preset-env \
    core-js
```

Configure Webpack. Set up a `webpack.config.js` file
```javascript
const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    login: './src/login.test.js',
    signup: './src/signup.test.js',
  },
  output: {
    path: path.resolve(__dirname, 'dist'), // eslint-disable-line
    libraryTarget: 'commonjs',
    filename: '[name].bundle.js',
  },
  module: {
    rules: [{ test: /\.js$/, use: 'babel-loader' }],
  },
  target: 'web',
  externals: /k6(\/.*)?/,
};
```