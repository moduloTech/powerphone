export const isUndefined = (obj) => obj === undefined
export const isNull = (obj) => obj === null
export const isNullOrUndefined = (obj) => isNull(obj) || isUndefined(obj)
export const isNotNullOrUndefined = (obj) => !isNullOrUndefined(obj)
export const setWithDefault = (value, _default) => isUndefined(value) || isNull(value) || isBlank(value) ? _default : value
export const isPresent = (obj) => !isNullOrUndefined(obj) && obj !== '' && obj !== [] && obj !== {} && ((typeof obj === 'string' && !obj.match(/^\s*$/)) || true)
export const isBlank = (obj) => !isPresent(obj)

export const htmlNodeFromText = (text) => {
  const template = document.createElement('template')
  template.innerHTML = text
  const node = template.content.cloneNode(true)
  return node.children[0]
}

export const UUIDv4 = new function () {
  function generateNumber (limit) {
    const value = limit * Math.random()
    return value | 0
  }

  function generateX () {
    const value = generateNumber(16)
    return value.toString(16)
  }

  function generateXes (count) {
    let result = ''
    for (let i = 0; i < count; ++i) {
      result += generateX()
    }
    return result
  }

  function generateVariant () {
    const value = generateNumber(16)
    const variant = (value & 0x3) | 0x8
    return variant.toString(16)
  }

  // UUID v4
  //
  //   varsion: M=4
  //   variant: N
  //   pattern: xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx
  //
  this.generate = function () {
    return generateXes(8) + '-' + generateXes(4) + '-' + '4' + generateXes(3) + '-' + generateVariant() + generateXes(3) + '-' + generateXes(12)
  }
}()
