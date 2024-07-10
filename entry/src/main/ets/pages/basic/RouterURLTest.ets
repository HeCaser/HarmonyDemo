import Url from '@ohos.url'
import { router } from '@kit.ArkUI'
import { mapCommon } from '@kit.MapKit'
import { HashMap } from '@kit.ArkTS'

@Component
export struct RouterURLTest {
  private test(url: string) {
    url = url.trim()
    const URL = Url.URL.parseURL(url)
    const pathName = URL.pathname


    let params: Record<string, string> = {}

    for (const item of URL.params.entries()) {
      params[item[0]] = item[1]

    }

    router.pushUrl({
      url: "pages/router/Page2",
      params: params
    })
  }

  build() {

    Button("Test url").onClick(() => {
      this.test('https://danjuanfunds.com/native/GestureSetPage?a=adasa&b=我是中文&c=1')
    })
  }
}