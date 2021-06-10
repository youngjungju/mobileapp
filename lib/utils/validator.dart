class TitleValidator {
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return '입력창이 비어있습니다. 이력서 제목을 입력해주세요.';
    }
    return null;
  }
}

class TextValidator {
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return '입력창이 비어있습니다. 자기소개서를 입력해주세요.';
    }
    else if(value.length < 50) {
      return '최소 50자 이상 입력해주세요.';
    }
    else if(value.length > 500) {
      return '500자를 초과했습니다.';
    }
    return null;
  }
}

