let ooxx = "fk ";
let blog =`花蓮縣政府  <br/>
${ooxx}  <br/>
卻被爆挪用8億多元給當地業者紓困`;


document.write(blog);
document.write('<br/>');
document.write(ooxx.startsWith('f'));
document.write('<br/>');
document.write(ooxx.endsWith('k'));
document.write('<br/>');
document.write(ooxx.repeat(30));

console.clear();
console.log(Number.isFinite('1'));
console.log(Number.isFinite(1));
console.log(Number.MAX_SAFE_INTEGER)
console.log(['a','b'].toString())
console.log(Array.of(['a','b'].toString()))