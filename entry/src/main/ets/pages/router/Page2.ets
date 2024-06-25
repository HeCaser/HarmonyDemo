import { router } from '@kit.ArkUI';

export  class A {
  callBack:Function = (type:number, data:string) => {
  }
}

@Entry
@Component
struct Page2 {
  @State message: string = 'Hello World';

  a?:A = undefined

  build() {
    Column() {
      Text("页面 Page2")
      Button("Click").onClick(()=>{
        console.log("hepan callback = "+JSON.stringify(this.a))
        this.a?.callBack?.(1,"0")
      })
    }.width(100)

  }

  showDialog() {

  }

  aboutToAppear(): void {
    const param = router.getParams()
    if (param) {
      let p = param as A
      if (p) {
        console.log("hepan para = " + JSON.stringify(p))
        this.a = p
      }

    }
  }

  // onAppear(event: () => void): CommonAttribute {
  //
  //   return super.onAppear(event)
  // }
}

