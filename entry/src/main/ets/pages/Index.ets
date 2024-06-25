import { PwdGridView } from './pwd_check/view/PwdGridView';
import { KeyboardView } from './pwd_check/view/KeyboardView';

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

      // PwdGridView({ pwd: this.pwd }).margin({ left: 12, right: 12 }).height(40)
      KeyboardView({
        onItemClick: (type, value) => {
          console.log(`hepan ${type} - ${value}`)
        }
      }).height(200)
    }.width('100%')
  }
}

