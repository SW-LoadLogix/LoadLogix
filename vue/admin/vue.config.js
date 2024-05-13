const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,

  devServer: {
    port: 8080, // 프론트엔드 개발 서버의 포트
    proxy: {
      '/api': {
        target: 'http://localhost:8081', // 백엔드 서버 주소
        changeOrigin: true,
        pathRewrite: { '^/api': '' } // '/api' 부분을 URL에서 제거
      }
    }
  }
})
