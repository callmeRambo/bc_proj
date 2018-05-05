<%@ page language="java" import="java.util.*, javax.servlet.*,com.mongodb.*" pageEncoding="UTF-8"%>
<%

    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    // add
    // get all address
    String buyerAddrCookie = "";
    String buyerContractAddrCookie = "";
    String sellerContractAddrCookie = "";

    String clientContractAddrCookie = "";


    String freelancerContractDeployed = "";
    String clientContractDeployed = "";
    Cookie[] cookies = request.getCookies();

    class combo{
        String userAddress = "";
        String clientContractAddr = "";
    }
    ArrayList<combo> container = new ArrayList<combo>();
    //combo c = new combo();

    try{
        MongoClient mongoClient3 = new MongoClient( "localhost" , 27017 );
        DB db3 = mongoClient3.getDB( "test" );
        DBCollection coll3 = db3.getCollection("address");
        DBCursor cursor3 = coll3.find();
        while (cursor3.hasNext()) {
            combo c = new combo();
            DBObject show3 = cursor3.next();
            Map show4 = show3.toMap();
            buyerAddrCookie = (String)show4.get("buyerAddrCookie");
            clientContractAddrCookie = (String)show4.get("clientContractDeployed");
            System.out.println("kkk"+clientContractAddrCookie);
            c.userAddress = buyerAddrCookie;
            c.clientContractAddr = clientContractAddrCookie;
            container.add(c);
        }
    }catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }

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
    //required for freelancer contract

    //String freelancerContractAddr = freelancerContractDeployed;

    String searchPattern = (String)request.getParameter("search"); // this is search pattern, if pattern == "", show all models
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>accepting</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Poppins:400,600" rel="stylesheet">
    <link rel="shortcut icon" href="assets/images/favicon.png" >
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/fontAwesome.css">
    <link rel="stylesheet" href="css/hero-slider.css">
    <link rel="stylesheet" href="css/owl-carousel.css">
    <link rel="stylesheet" href="css/tempo1.css">
    <link rel="stylesheet" href="css/lightbox.css">
    <link href="assets/css/theme.css" rel="stylesheet">
    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    <script src="js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="js/cartmain.js"></script> <!-- Resource jQuery -->
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" href="css/cartstyle.css">
    <script language="javascript" type="text/javascript" src="ClientABI.js"></script>
    <script language="javascript" type="text/javascript" src="FreelancerABI.js"></script>
    <script language="javascript" type="text/javascript" src="js/web3.js"></script>
</head>
<body class="">


<div class="header">
    <div class="container">
        <nav class="navbar navbar-inverse" role="navigation">
            <div class="navbar-header">
                <a class="navbar-brand"><em>M</em>UD</a>
            </div>
            <div id="main-nav" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a style="font-size: 18px;">Username</a></li>
                    <li><button style="font-size: 18px;" type="button" class="scroll-top">Switch</button></li>
                    <li><button style="font-size: 18px;" type="button" class="logout" data-id="logout">Logout</button></li>
                </ul>
            </div>
        </nav>
    </div>
</div>


<div class="parallax-content baner-content" id="home">
    <div class="container">
        <div class="text-content">
            <h2>Awesome <span>Algorithm</span> Trading <em>Website</em></h2>
        </div>
    </div>
</div>


<section id="home-property-listing">
    <header class="section-header home-section-header text-center">
        <div class="container">
            <h2 class="wow slideInRight">Search result</h2>
            <a style="font-size: 18px;" type="button" href="buyermainpage.jsp">Go back</a>
        </div>
    </header>
    <div class="container">
        <div class="row" id="mapping_things">
        </div>
    </div>
</section>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-sm-12">
                COMP9900 2018S1
            </div>
            <div class="col-md-4 col-sm-12">
                Playing with Mud
            </div>
        </div>
    </div>
</footer>


<a href="#top" id="scroll-top"><i class="fa fa-angle-up"></i></a>
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.migrate.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<%--<script src="http://ditu.google.cn/maps/api/js?key=AIzaSyD2MtZynhsvwI2B40juK6SifR_OSyj4aBA&libraries=places"></script>--%>
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="ClientABI.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        $('.scroll-link').on('click', function(event){
            event.preventDefault();
            var t = $(window).scrollTop();
            $('body,html').animate({'scrollTop':t+900},1000)
        });
        viewAllModelsMultiSeller();
        // scroll to top action
        $('.scroll-top').on('click', function(event) {
            event.preventDefault();
            window.location.href=("start.jsp");
        });
        // mobile nav toggle
        $('#nav-toggle').on('click', function (event) {
            event.preventDefault();
            $('#main-nav').toggleClass("open");
        });
        $('.logout').on('click', function(event){
            event.preventDefault();
            window.location.href=("login.jsp");
        });
    });

    if (typeof console === "undefined") {
        console = {
            log: function() { }
        };
    }

    // Note that this is search result
    function viewAllModelsMultiSeller() {
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // Insert ABI
        let ClientABI = web3.eth.contract(ClientABIContent);
        // get all sellers and their contracts
        var allClients = [];
        <%for(int i=0;i<container.size();i++){%>
        allClients.push("<%= container.get(i).userAddress%>");
        <%}%>
        var allClientContracts = [];
        <%for(int i=0;i<container.size();i++){%>
        allClientContracts.push("<%= container.get(i).clientContractAddr%>");
        <%}%>
        console.log("All clients address: " + allClients);
        console.log("All clients contracts address: " + allClientContracts);
        $("#mapping_things").empty();
        for (let j = 0; j < allClients.length; j++){
            // Get access to contract

            console.log("client : " + allClients[j]);
            web3.eth.defaultAccount = allClients[j];

            let Client_contract = ClientABI.at(allClientContracts[j]);
            console.log("cc : " + Client_contract);
            // Get model count
            console.log("Index : " + j);

//            let requestCount = Client_contract.getRequestCount.call({from: web3.eth.defaultAccount});

            //console.log("requestCount : " +requestCount);
            for(let i = 0; i < 100; i++){
                try {

                    <%--Client address : ${resultVisible[0]}</br>--%>
                    <%--Request index : ${resultInvisible[5]}</br>--%>
                    <%--Request name : ${resultVisible[1]}</br>--%>
                    <%--Request description : ${resultVisible[2]}</br>--%>
                    <%--Request reward : ${web3.fromWei(resultVisible[4], 'ether')} ether</br>--%>
                    <%--Request threshold : ${resultVisible[5]}</br>--%>
                    <%--Request time : ${new Date(Number(resultVisible[6]))}</br>--%>
                    <%--Request end : ${resultInvisible[1]}</br>--%>
                    <%--=== === === === ===</br>--%>

                    // get information
                    let resultVisible = Client_contract.getRequestByIndexVisible.call(i, {from: web3.eth.defaultAccount});
                    let resultInvisible = Client_contract.getRequestByIndexInvisible.call(i, {from: web3.eth.defaultAccount});

                    let currentName = resultVisible[1].toLowerCase();
//                    console.log("index"+resultInvisible[5]);
                    let searchPattern = "<%=searchPattern%>".toLowerCase();


                    //console.log("Current client_addr : " + client_addr);
                    let client_contract_addr = allClientContracts[j];

//                    console.log("Current name : " + currentName);

                    //如果直接访问该网页需要这句，
                    searchPattern= "";

//                    console.log("Search pattern : " + searchPattern);
                    if (searchPattern == "") { // show all models
                        console.log("here:"+resultVisible[0]);
                        let newHeader = '<div class="divs" id="anlidesc" style="width:721px; height:450px" >' +
                            '<ul>' +
                            '<h3>Request</h3>' +
                            'Client address: <li class = client_addr>' + resultVisible[0] + '</li>' +
                            'Client contract address: <li class="client_contract_addr">' + allClientContracts[j] + '</li>' + // seller contract address (hidden on html)
                            'Request index: <li class="request_index" >' + resultInvisible[5] + '</li>' +
                            '<li>Request name' + resultVisible[1] + '</li>' +
                            '<li>Request description' + resultVisible[2] + '</li>' +
                            '<li>Reward (ether) : ' + web3.fromWei(resultVisible[4], 'ether') + '</li>' +
                            '<li>threshold : ' + resultVisible[5] + '</li>' +
                            '<li>Time : ' + new Date(Number(resultVisible[6])) + '</li>' +
                            '<li  class="end">end : ' + resultInvisible[1] + '</li>' +
                            '<li>- - - - -</li>' +
                            '</ul><input type="button" class="add_to_accepting_cart" value="Add to cart" /></div>';
                        $("#mapping_things").append(newHeader).trigger("pagecreate");
                    }
                    else if(currentName.match(searchPattern)){ // only show matched models
                        let newHeader = '<div class="divs" id="anlidesc" style="width:721px; height:450px" >' +
                            '<ul>' +
                            '<h3>Request</h3>' +
                            'Client address: <li class = client_addr>' + resultVisible[0] + '</li>' +
                            'Client contract address: <li class="client_contract_addr">' + allClientContracts[j] + '</li>' + // seller contract address (hidden on html)
                            'Request index: <li class="request_index" >' + resultInvisible[5] + '</li>' +
                            '<li>Request name' + resultVisible[1] + '</li>' +
                            '<li>Request description' + resultVisible[2] + '</li>' +
                            '<li>Reward (ether) : ' + web3.fromWei(resultVisible[4], 'ether') + '</li>' +
                            '<li>threshold : ' + resultVisible[5] + '</li>' +
                            '<li>Time : ' + new Date(Number(resultVisible[6])) + '</li>' +
                            '<li  class="end">end : ' + resultInvisible[1] + '</li>' +
                            '<li>- - - - -</li>' +
                            '</ul><input type="button" class="add_to_accepting_cart" value="Add to cart" /></div>';
                        $("#mapping_things").append(newHeader).trigger("pagecreate");
                    }
                }
                catch (error){
                    console.log("Error : " + error);
                    break;
                }
            }
        }
        // add to accepting cart
        $("body").on("click",".add_to_accepting_cart", function() {
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

            let clientAddr = $(this).parent().find(".client_addr").text();
            let clientContractAddr = $(this).parent().find(".client_contract_addr").text();
            let requestIndex = $(this).parent().find(".request_index").text();

                web3.eth.defaultAccount = clientAddr;

                let Client_contract = ClientABI.at(clientContractAddr);
                // Get the information of request

                let resultVisible = Client_contract.getRequestByIndexVisible.call(requestIndex, {from: web3.eth.defaultAccount});
                let resultInvisible = Client_contract.getRequestByIndexInvisible.call(requestIndex, {from: web3.eth.defaultAccount});
                console.log(resultVisible.length);
//        // check whether the request is end
//        if (resultInvisible[1]) {
//            alert("This request has been closed!");
//        }
//        else{
                // Get access to freelancer's contract
                let freelancerAddr = clientAddr;
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
                        console.log("fail!");

//                        $("#Info_test2").html("Failed!</br>");
                    }
                });
                acceptRequestResult.stopWatching();
                //           }
                //}
            });
    }
//
//            let clientAddr = $(this).parent().find(".client_addr").text();
//            let clientContractAddr = $(this).parent().find(".client_contract_addr").text();
//            let requestIndex = $(this).parent().find(".request_index").text();
//            console.log("clientAddr : " + clientAddr);
//            console.log("clientContractAddr : " + clientContractAddr);
//            console.log("requestIndex : " + requestIndex);
//            // send data to shopping_action.jsp --> store in DB
//            $.ajax({
//                url: 'accepting_action.jsp', // Yunqiu Xu : why shopping_action.jsp here?
//                type: 'POST',
//                async: false,
//                data: {clientAddr:clientAddr, clientContractAddr:clientContractAddr, requestIndex:requestIndex},
////                data: {clientAddr:clientAddr, clientContractAddr:clientContractAddr, requestIndex:requestIndex},
//                success: function (result) {
////                    window.location.href="accepting_action.jsp";
//                    //console.log("Accepting request successfully");
//                    if(result.resultCode == 200){
//                    alert('succeed!');
//                    }
//                    else{
//                        alert('YOU HAVE FAILED THIS CITY')
//                    }
//                },
//                error: function (returndata) {
//                    //console.log("Failed");
//                    alert('failed!')
//                }
//            });
//        });
//    }
</script>

</body>
</html>


