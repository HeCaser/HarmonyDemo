import { PwdCheck } from './pwd_check/PwdCheckComponent';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      // PwdCheckComponent(){
      //
      // }

      PwdCheck()
    }

  }
}

