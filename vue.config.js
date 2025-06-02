const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true
})
// vue.config.js

module.exports = {
  configureWebpack: {
    module: {
      rules: [
        {
          test: /\.m4a$/,
          use: [
            {
              loader: 'file-loader',
              options: {
                name: 'assets/music/[name].[hash:8].[ext]'
              }
            }
          ]
        }
      ]
    }
  }
}