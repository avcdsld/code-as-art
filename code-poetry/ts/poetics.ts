type 構造 = {
  因果: () => boolean
}

type 効果 = {
  響き: () => boolean
}

type 感性 = {
  閃き: () => boolean
}

type 変容 = {
  再解釈: () => boolean
}

const 詩 = (_構造: 構造, _効果: 効果, _感性: 感性, _変容: 変容) => {
  return 実行(
    _構造.因果() &&
    _効果.響き() &&
    _感性.閃き() &&
    _変容.再解釈()
  )
}
