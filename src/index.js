let ooxx = "fk ";
let blog = `花蓮縣政府  <br/>
${ooxx}  <br/>
卻被爆挪用8億多元給當地業者紓困`;
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------

document.write(blog);
document.write('<br/>');
document.write(ooxx.startsWith('f'));
document.write('<br/>');
document.write(ooxx.endsWith('k'));
document.write('<br/>');
document.write(ooxx.repeat(30));

  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------

{
    let a,b,rest;
    [a,b]=[1,2];
    console.log(a,b);
  }
  
  {
    let a,b,rest;
    [a,b,...rest]=[1,2,3,4,5,6];
    console.log(a,b,rest);
  }
  
  {
    let a,b;
    ({a,b}={a:1,b:2})
    console.log(a,b);
  }
  
  {
    let a,b,c,rest;
    [a,b,c=3]=[1,2];
    console.log(a,b,c);
  }
  
  {
    let a=1;
    let b=2;
    [a,b]=[b,a];
    console.log(a,b);
  }
  
  {
    function f(){
      return [1,2]
    }
    let a,b;
    [a,b]=f();
    console.log(a,b);
  }
  
  {
    function f(){
      return [1,2,3,4,5]
    }
    let a,b,c;
    [a,,,b]=f();
    console.log(a,b);
  }
  
  {
    function f(){
      return [1,2,3,4,5]
    }
    let a,b,c;
    [a,,...b]=f();
    console.log(a,b);
  }
  
  {
    let o={p:42,q:true};
    let {p,q}=o;
    console.log(p,q);
  }
  
  {
    let {a=10,b=5}={a:3};
    console.log(a,b);
  }
  
  {
    let metaData={
      title:'abc',
      test:[{
        title:'test',
        desc:'description'
      }]
    }
    let {title:esTitle,test:[{title:cnTitle}]}=metaData;
    console.log(esTitle,cnTitle);
  }

  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------


console.clear();
console.log(Number.isFinite('1'));
console.log(Number.isFinite(1));
console.log(Number.MAX_SAFE_INTEGER)
console.log(['a', 'b'].toString())
console.log(Array.of(['a', 'b'].toString()))

