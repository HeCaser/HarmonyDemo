import { router } from '@kit.ArkUI';
import url from '@ohos.url';

export class A {
  callBack: Function = (type: number, data: string) => {
  }
}

@Entry
@Component
struct Page2 {

  @State message: string = 'Hello World';

  build() {
    Column() {
      Text("页面 Page2")
      Button("Click").onClick(()=>{

      })
    }.width(100)

  }

  showDialog() {

  }

  aboutToAppear(): void {
    const param = router.getParams()
    if (param) {

      let p = param as Record<string,string>
      let a = p.a
      console.log(`hepan 参数 = ${JSON.stringify(a)}`);

      // c == "1", 字符串类型
      let c = p.c

    }
  }

  // onAppear(event: () => void): CommonAttribute {
  //
  //   return super.onAppear(event)
  // }
}

