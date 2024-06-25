import { PwdGridView } from './pwd_check/view/PwdGridView';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '*-03456';

  test() {

  }

  build() {
    Column({ space: 10 }) {
      Button("Test").onClick(() => {
        this.test()
      }).width(100)

      PwdGridView({ pwd: this.pwd }).margin({ left: 12, right: 12 }).height(40)
    }.width('100%')
  }
}

