var getSelectedTab = (tab) => {
  var tabId = tab.id;
  var sendUserNamePassword = (val) => chrome.tabs.executeScript(tabId, val);
  document.getElementById('myPay').addEventListener('click', () => sendUserNamePassword({ code: 'document.getElementById("name").value = "zonpay";document.getElementById("pwd").value = "0221mypay@zonvan";document.getElementById("code").value = "c";' }));
  document.getElementById('rd').addEventListener('click', () => sendUserNamePassword({ code: 'document.getElementById("name").value = "mypay";document.getElementById("pwd").value = "mypay@zonvan";' }));
  document.getElementById('myPayTest').addEventListener('click', () => sendUserNamePassword({ code: 'document.getElementById("name").value = "zonvan";document.getElementById("pwd").value = "Zonvan123";document.getElementById("code").value = "c";' }));
  document.getElementById('myPayCenterTest').addEventListener('click', () => sendUserNamePassword({ code: 'document.getElementById("name").value = "zonvan";document.getElementById("pwd").value = "Zonvan123";' }));
}
chrome.tabs.getSelected(null, getSelectedTab);