<%@ page language="java" import="java.util.*,com.mongodb.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


    // get all cookies
    Cookie[] cookies = request.getCookies();

    // get all address
    String buyerAddrCookie = ""; // note that here buyerAddrCookie is user's address, not contract
    String buyerContractAddrCookie = "";
    String sellerContractAddrCookie = "";
    String freelancerContractDeployed = "";
    String clientContractDeployed = "";

    for (int i = 0; i < cookies.length; i++) {
        if ("buyerAddrCookie".equals(cookies[i].getName())) {
            buyerAddrCookie = java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println(buyerAddrCookie);
        }
        if ("buyerContractAddrCookie".equals(cookies[i].getName())) {
            buyerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("buyer contract address : " + buyerContractAddrCookie);
        }
        if ("sellerContractAddrCookie".equals(cookies[i].getName())) {
            sellerContractAddrCookie =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("seller contract address : " + sellerContractAddrCookie);
        }
        if ("freelancerContractDeployed".equals(cookies[i].getName())) {
            freelancerContractDeployed =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("freelancer contract address : " + freelancerContractDeployed);
        }
        if ("clientContractDeployed".equals(cookies[i].getName())) {
            clientContractDeployed =  java.net.URLDecoder.decode(cookies[i].getValue(),"UTF-8");
            System.out.println("client contract address : " + clientContractDeployed);
        }
    }
    String freelancerAddr = buyerAddrCookie;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>My JSP 'register_action.jsp' starting page</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta http-equiv="description" content="This is my page">
    <script language="javascript" type="text/javascript" src="ClientABI.js"></script>
    <script language="javascript" type="text/javascript" src="FreelancerABI.js"></script>
    <script language="javascript" type="text/javascript" src="js/web3.js"></script>

</head>

<body>
<%
//    response.setContentType("text/html;charset=utf-8");
//    // get infomation from request
//    request.setCharacterEncoding("utf-8");
//    // here only seller's address, seller contract's address and model's index
    String clientAddr =(String)request.getParameter("clientAddr");
    System.out.println("XXX:"+clientAddr);
    String clientContractAddr =(String)request.getParameter("clientContractAddr");
    System.out.println("AAA:"+clientContractAddr);
    String requestIndex =(String)request.getParameter("requestIndex");
    System.out.println("BBB:"+requestIndex);
//
//    System.out.println(clientAddr.equals("0xeaeca1d68149b524bd4818e0362c4f6235a6849d"));
//    System.out.println(clientContractAddr.equals("0x0e3efab666e3493a0f6bd2d5361b5c56e4d2137a"));
//    System.out.println(requestIndex.equals("0"));

    clientAddr = "0x8d03375195f6e941ee75ec5aa588b26c39f0c19e";
    clientContractAddr = "0x17225930a5b1443a9b69ff2a3f46f13e590e26be";
    requestIndex = "0";


    //response.sendRedirect("accepting.jsp");

//
//    try{
//        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
//        @SuppressWarnings("deprecation")
//        DB db = mongoClient.getDB("test");
//        DBCollection coll = db.getCollection("shopping");
//        System.out.println("Collection userInfo selected successfully");
//        DBObject user = new BasicDBObject();
//        user.put("buyerMetaAddr", buyerAddrCookie);
//        user.put("buyerContraAddr", buyerContractAddrCookie);
//        user.put("sellerMetaAddr", sellerAddr);
//        user.put("sellerContraAddr", sellerContractAddr);
//        user.put("modelIndSeller", modelIndex);
//        coll.insert(user);
//        response.sendRedirect("shopping.jsp");
//    }catch(Exception e){
//        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
//    }
%>
<script type="text/javascript">
    function acceptRequest() {
        <%--<%--%>
           <%--System.out.println(clientAddr.equals("0xeaeca1d68149b524bd4818e0362c4f6235a6849d"));--%>
    <%--System.out.println(clientContractAddr.equals("0x0e3efab666e3493a0f6bd2d5361b5c56e4d2137a"));--%>
   <%--System.out.println(requestIndex.equals("0"));%>--%>

        //$("#Info_test2").empty();
        // Get access to client's contract
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        let ClientABI = web3.eth.contract(ClientABIContent);
        let FreelancerABI = web3.eth.contract(FreelancerABIContent);

        let clientAddr = "<%=clientAddr%>";
        let clientContAddr = "<%=clientContractAddr%>";
        web3.eth.defaultAccount = clientAddr;

        let Client_contract = ClientABI.at(clientContAddr);
        // Get the information of request
        let requestIndex = <%=requestIndex%>;

        let resultVisible = Client_contract.getRequestByIndexVisible.call(requestIndex, {from: web3.eth.defaultAccount});
        let resultInvisible = Client_contract.getRequestByIndexInvisible.call(requestIndex, {from: web3.eth.defaultAccount});
        console.log(resultVisible.length);
//        // check whether the request is end
//        if (resultInvisible[1]) {
//            alert("This request has been closed!");
//        }
//        else{
            // Get access to freelancer's contract
            let freelancerAddr = "<%=freelancerAddr%>";
            let freelancerContAddr = "<%=freelancerContractDeployed%>";
            web3.eth.defaultAccount = freelancerAddr;
            let Freelancer_contract = FreelancerABI.at(freelancerContAddr);
            // Check whether this request has been accepted by this freelancer
//            let repeatResult = Freelancer_contract.checkRepeat.call(clientAddr, requestIndex, {from: web3.eth.defaultAccount, gas: 30000000});
//            if (repeatResult) {
//                console.log("You've accepted this request before so you can not buy it again!!!");
//            }
//            else{
                // Accept the request

        Freelancer_contract.acceptRequest.sendTransaction(clientAddr, requestIndex, {from: web3.eth.defaultAccount, gas: 30000000});

        // Watch the event
                let acceptRequestResult = Freelancer_contract.RequestAccepted(function(error, result){
                    if (!error){
//                        $("#Info_test2").html("Accept request successfully!</br>");
                        console.log("succ!");
                        console.log(result);
                    }
                    else{
                        <%System.out.println("clientAddr fail "+clientAddr);%>

//                        $("#Info_test2").html("Failed!</br>");
                    }
                });
                acceptRequestResult.stopWatching();
 //           }
        //}
    }

    window.onload = acceptRequest();
</script>
</body>
</html>