const express = require("express")
const router = express.Router()
let mysql = require('mysql');

router.use(logger)
let db = mysql.createConnection(
    {
     host: 'localhost',
     user: 'root',
     password: '',
     database: '22105239'
    }
   );
   
db.connect((err) => {
    console.log('Connected!');
}); 


router.get("/", (req, res) => {
    res.setHeader('Content-Type', 'text/html');
    res.render('Home.html');
})

router.get("/NewParcel", (req, res) => {
    SqlCus="SELECT custId,custName FROM customers;"
    db.query(SqlCus,(err, Cusrows, fields) => {
        if (err) throw err
        SqlLoc="SELECT `LocId`,`locAddress`,`city` FROM `locations`"
        db.query(SqlLoc,(err, Locrows, fields) => {
            if (err) throw err
                res.setHeader('Content-Type', 'text/html');
                res.render('NewParcel.html',{Cusrows,Locrows});
        })
    })
    
})

router.get("/MyParcels", (req, res) => {
    if(req.query.customer){
        SqlCus="SELECT custId,custName FROM customers;"
        db.query(SqlCus,(err, customers, fields) => {
            ParcelSql="SELECT p.parcelId as parcelid,p.weight as weight,l.locAddress as finalAdd,l.city as FinalCity from parcels as p,locations as l, customers as c WHERE c.custId=p.custId and p.finalLocation=l.LocId and c.custId=?;"
            valuesforParcelSql=[req.query.customer,]
            db.query(ParcelSql,valuesforParcelSql,(err, ParcelData, fields) => {
                FromLocSql="SELECT l.locAddress as fromadd,l.city as fromcity FROM locations as l,customers as c WHERE c.custLocation=l.locid and c.custid=?;"
                valuesforFromLocSql=[req.query.customer,]
                db.query(FromLocSql,valuesforFromLocSql,(err, fromData, fields) => {
                    res.setHeader('Content-Type', 'text/html');
                    res.render('MyParcels.html',{customers,ParcelData,fromData});
                })
            })
            
        })
    }
    else{
        SqlCus="SELECT custId,custName FROM customers;"
        db.query(SqlCus,(err, customers, fields) => {
            res.setHeader('Content-Type', 'text/html');
            res.render('MyParcels.html',{customers,ParcelData:0,fromData:0});
        })
    }
})

router.get("/OrderSummary", (req, res) => {
    res.redirect('./NewParcel') 
})

router.post("/OrderSummary",express.urlencoded({extended: true}), (req, res) => {
    if(req.body.customer && req.body.weight && req.body.location){
        queryjson=req.body
        weight=parseInt(queryjson.weight);
        customer=parseInt(queryjson.customer);
        location=parseInt(queryjson.location);
        ParcelSql="INSERT INTO `parcels` (`parcelId`, `weight`, `custId`, `finalLocation`) VALUES (NULL, '?', '?', '?');"
        valuesForParcel=[weight,customer,location]
        if(db.query(ParcelSql,valuesForParcel,(err,fields) => {})){
            idSql="SELECT `parcelId` FROM `parcels` WHERE `weight`=? AND `custId`=? and `finalLocation`=?";
            valuesforIdSql=[weight,customer,location];
            db.query(idSql,valuesforIdSql,(err, Parcelid, fields) => {
               custSql="SELECT c.custName as CustName,L.locAddress as Address,l.city as City FROM customers as c,locations as l WHERE c.custLocation=l.locId and c.custid=?;"
               valuesforCust=[customer,]
               db.query(custSql,valuesforCust,(err, CustomerDet, fields) => {
                    FinLocation="SELECT locAddress,city FROM `locations` WHERE `LocId`=?"
                    valuesforFinLocation=[location,]
                    db.query(FinLocation,valuesforFinLocation,(err, finalLocation, fields) => {
                        res.setHeader('Content-Type', 'text/html');
                        res.render('OrderSummary.html',{Parcelid,CustomerDet,finalLocation});
                    })
               })
            })
        }else{
            res.redirect('./NewParcel') 
        }
       
    }else{
        res.redirect('./NewParcel') 
    }
    
})

function logger(req, res, next) {
    next()
}
  
module.exports = router