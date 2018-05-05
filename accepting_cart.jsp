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
%>
<%
    class info
    {
        String sellerMetaAddr;
        String sellerContraAddr;
        String modelIndSeller;
    }

    ArrayList<info> result = new ArrayList<info>();
    try{
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
        DB db = mongoClient.getDB( "test" );
        DBCollection coll = db.getCollection("shopping");
        System.out.println("Collection userInfo selected successfully");
        DBCursor cursor = coll.find();

        int i=1;
        while (cursor.hasNext()) {
            info in = new info();
            System.out.println("userInfo Document: "+i);
            DBObject show = cursor.next();
            System.out.println(show);
            Map show1 = show.toMap();
            String buyerMetaAddr = (String)show1.get("buyerMetaAddr");
            if(buyerMetaAddr.equals(buyerAddrCookie)){
                // String buyerContraAddr = (String)show1.get("buyerContraAddr");
                String sellerMetaAddr = (String)show1.get("sellerMetaAddr");
                String sellerContraAddr = "";
                try{
                    MongoClient mongoClient3 = new MongoClient( "localhost" , 27017 );
                    DB db3 = mongoClient3.getDB( "test" );
                    DBCollection coll3 = db3.getCollection("address");
                    DBCursor cursor3 = coll3.find();
                    while (cursor3.hasNext()) {
                        DBObject show3 = cursor3.next();
                        Map show4 = show3.toMap();
                        System.out.println(show4);
                        String tobuyerAddrCookie = (String)show4.get("buyerAddrCookie");
                        tobuyerAddrCookie = tobuyerAddrCookie.toLowerCase();
                        if(tobuyerAddrCookie.equals(sellerMetaAddr.toLowerCase())){
                            sellerContraAddr = (String)show4.get("sellerContractAddrCookie");
                            System.out.println(sellerContraAddr +" 777777777777777");
                        }
                    }

                }
                catch(Exception e){
                    System.err.println( e.getClass().getName() + ": " + e.getMessage() );
                }
                String modelIndSeller = (String)show1.get("modelIndSeller");
                in.sellerMetaAddr = sellerMetaAddr;
                in.sellerContraAddr = sellerContraAddr;
                in.modelIndSeller = modelIndSeller;
                result.add(in);
            }
            i++;
        }
    }
    catch(Exception e){
        System.err.println( e.getClass().getName() + ": " + e.getMessage() );
    }
%>


<!DOCTYPE html>


<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>shopping cart</title>
    <!-- Styles -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Poppins:400,600" rel="stylesheet">
    <!-- favicon and touch icons -->
    <link rel="shortcut icon" href="assets/images/favicon.png" >
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
    <!--<link rel="apple-touch-icon" href="apple-touch-icon.png">-->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/fontAwesome.css">
    <link rel="stylesheet" href="css/hero-slider.css">
    <link rel="stylesheet" href="css/owl-carousel.css">
    <link rel="stylesheet" href="css/tempo1.css">
    <link rel="stylesheet" href="css/lightbox.css">
    <!-- Bootstrap -->
    <!--<link href="assets/css/bootstrap.css" rel="stylesheet">-->
    <link href="assets/css/theme.css" rel="stylesheet">
    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
    <script src="js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" href="css/cartstyle.css">
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
            <h2 class="wow slideInRight">My shopping cart</h2>
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
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.migrate.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="http://ditu.google.cn/maps/api/js?key=AIzaSyD2MtZynhsvwI2B40juK6SifR_OSyj4aBA&libraries=places"></script>
<script src="js/vendor/jquery-1.11.2.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script language="javascript" type="text/javascript" src="js/web3.js"></script>
<script language="javascript" type="text/javascript" src="SellerABI.js"></script>
<script language="javascript" type="text/javascript" src="BuyerABI.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#nav-toggle').on('click', function (event) {
            event.preventDefault();
            $('#main-nav').toggleClass("open");
        });
        // scroll to top action
        $('.scroll-top').on('click', function(event) {
            event.preventDefault();
            window.location.href=("start.jsp");
        });
        $('.logout').on('click', function(event) {
            event.preventDefault();
            window.location.href=("login.jsp");
        });
        showShoppingCart();
    });
    if (typeof console === "undefined") {
        console = {
            log: function() { }
        };
    }


    // show models in shopping cart, and buy model
    function showShoppingCart() {
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545")); // Ganache
        }
        // Insert ABI
        let SellerABI = web3.eth.contract(SellerABIContent);
        let BuyerABI = web3.eth.contract(BuyerABIContent);
        // Define buyerAddr and buyerContAddr
        let buyerAddr = "<%=buyerAddrCookie%>";
        let buyerContAddr = "<%=buyerContractAddrCookie%>";
        $("#mapping_things").empty();
        // Loop infos from DB begin
        <%for (int i = 0; i < result.size(); i++) {
            info details = result.get(i);
        %>
        // get info
        var sellerAddr = '<%=details.sellerMetaAddr%>';
        var sellerContAddr = '<%=details.sellerContraAddr%>';
        var modelIndexSeller = '<%=details.modelIndSeller%>';
        // get access to seller's contract
        web3.eth.defaultAccount = sellerAddr;
        var Seller_contract = SellerABI.at(sellerContAddr);
        // get information of this model
        var result = Seller_contract.getModelByIndex.call(modelIndexSeller, {from: web3.eth.defaultAccount});
        // display result, note that for buyer model address should not be given before buying
        var newHeader = '<div class="divs" id="anlidesc" style="width:721px; height:450px" >' +
            '<ul>' +
            '<h3>Model in shopping cart</h3>' +
            '<li hidden class="seller_address_buy_model">' + sellerAddr + '</li>' +              // hidden on html
            '<li hidden class="seller_contract_address_buy_model">' + sellerContAddr + '</li>' + // hidden on html
            '<li hidden class="model_index_buy_model">' + result[6] + '</li>' +                  // index (hidden on html)
            '<li>Name : ' + result[1] + '</li>' +
            '<li>Description : ' + result[2] + '</li>' +
            '<li>Price (ether) : ' + web3.fromWei(result[4], 'ether') + '</li>' +
            '<li>Time : ' + new Date(Number(result[5])) + '</li>' +
            '<a type="button" class="buy_model" href="shopping_cart.jsp">Buy this model</a>' +
            '<li>- - - - -</li>' +
            '</ul></div>';
        $("#mapping_things").append(newHeader).trigger("pagecreate");
        <%}%>
        // Loop infos from DB end

        // Buy model
        $("body").on("click",".buy_model", function() {
            // get information from html
            let sellerAddrBuyModel = $(this).parent().find(".seller_address_buy_model").text();
            let sellerContAddrBuyModel = $(this).parent().find(".seller_contract_address_buy_model").text();
            let modelIndexBuyModel = $(this).parent().find(".model_index_buy_model").text();
            // get access to seller's contract
            web3.eth.defaultAccount = sellerAddrBuyModel;
            let Seller_contract = SellerABI.at(sellerContAddrBuyModel);
            // get information for this model, note that we do not need to check repeat here
            let sellerModelDetails = Seller_contract.getModelByIndex.call(modelIndexBuyModel, {from: web3.eth.defaultAccount, gas: 30000000});
            // get access to buyer's contract
            web3.eth.defaultAccount = buyerAddr;
            let Buyer_contract = BuyerABI.at(buyerContAddr);
            // Buyer deposit money
            Buyer_contract.depositToContract.sendTransaction({from: buyerAddr, value: sellerModelDetails[4], gas: 30000000});
            // get bought time
            let timestamp = Date.parse(new Date());
            // buy model
            Buyer_contract.buyModel.sendTransaction(sellerModelDetails[0], sellerModelDetails[1], sellerModelDetails[2], sellerModelDetails[3],sellerModelDetails[4], timestamp, {from: buyerAddr, gas: 30000000});
        });
    }
</script>



</body>
</html>


