#Include C:\Programming\lib-v2\
#Include Json.ahk
print(i) {
    switch (o := '', Type(i)) {
    case 'Map', 'Array', 'Object':
        o := JSON.stringify(i)
    default:
        try o := String(i)
    }
	FileAppend(o, '*', 'utf-8')
}