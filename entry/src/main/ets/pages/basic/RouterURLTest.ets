import Url from '@ohos.url'

@Component
export struct RouterURLTest {
  private test(url: string) {
    url = url.trim()
    const URL = Url.URL.parseURL(url)
    const pathName = URL.pathname

    let param = URL.params


    for (const item of param.entries()) {
      console.log(`hepan item = ${JSON.stringify(item)}`);
    }


  }

  build() {

    Button("Test url").onClick(() => {
      this.test('https://danjuanfunds.com/native/GestureSetPage?a=adasa&b=我是中文')
    })
  }
}