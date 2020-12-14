package com.solutech.solutech_sat

import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import android.os.Bundle
import android.os.Handler
import android.widget.Toast
import com.datecs.fiscalprinter.FiscalResponse
import com.datecs.fiscalprinter.ken.FMP10KEN
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.*
import java.io.IOException
import java.util.*
import kotlin.coroutines.CoroutineContext
import kotlin.coroutines.createCoroutine

class MainActivity: FlutterActivity() {


  companion object {
    const val BLUETOOTH_CHANNEL:  String = "sat.solutech.com/bluetooth"
    const val FMP10_CHANNEL:  String = "sat.solutech.com/fmp10"
  }
  lateinit var fmP10KEN: FMP10KEN
  lateinit var bluetoothAdapter: BluetoothAdapter
  lateinit var bluetoothSocket: BluetoothSocket
  lateinit var bluetoothDevice: BluetoothDevice
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    initBluetoothMethodChannel()
    initFMP10MethodChannel()
  }

  override fun onDestroy() {
    super.onDestroy()
  }


  @SuppressLint("MissingPermission")
   fun onBluetoothConnect(address: String, result: MethodChannel.Result) {

      try {
        bluetoothAdapter =BluetoothAdapter.getDefaultAdapter()
        print("CALLED_NATIVE code for connect")
        val uuid = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")
        bluetoothDevice = bluetoothAdapter.getRemoteDevice(address)
        bluetoothSocket = bluetoothDevice.createRfcommSocketToServiceRecord(uuid)
        bluetoothSocket.connect()

        if (bluetoothSocket.isConnected) {
          fmP10KEN = FMP10KEN(bluetoothSocket.inputStream, bluetoothSocket.outputStream)
          Toast.makeText(this, "Connected to device ${bluetoothDevice.name}", Toast.LENGTH_SHORT).show()
          result.success(true)

        } else {
          Toast.makeText(this, "Connection failed", Toast.LENGTH_SHORT).show()
          result.success(false)
        }
      } catch (e: IOException) {
        print("Could not connect to device $e")
        Toast.makeText(this, "Could not connect to device", Toast.LENGTH_SHORT).show()
        result.success(false)
      }



  }

  fun initBluetoothMethodChannel(){
    MethodChannel(flutterView, BLUETOOTH_CHANNEL).setMethodCallHandler { call, result ->
      when(call.method){
        "onBluetoothConnect" -> {
          val address: String = call.argument("address") ?:""
            onBluetoothConnect(address, result)

        }
      }
    }
  }

  fun initFMP10MethodChannel(){
    MethodChannel(flutterView, FMP10_CHANNEL).setMethodCallHandler { call, result ->
      when(call.method){
        "openFiscalCheckWithDefaultValues" -> {
          val response = fmP10KEN.openFiscalCheckWithDefaultValues()
          result.success(response.toString())
        }

        "command54Variant0Version0" -> {
          val text: String = call.argument("text") ?:""
          val response = fmP10KEN.command54Variant0Version0(text)
          result.success(response.toString())
        }

        "sellThisWithQuantity"->{
          val saleDescription: String = call.argument("saleDescription") ?:""
          val taxCode: String = call.argument("taxCode") ?:""
          val singlePrice: String = call.argument("singlePrice") ?:""
          val quantity: String = call.argument("quantity") ?:""
          val response = fmP10KEN.sellThisWithQuantity(saleDescription,taxCode,singlePrice,quantity)
          result.success(response.toString())
        }



        "command51Variant0Version1"->{
          val subTotalWithPercentDiscount: String = call.argument("subTotalWithPercentDiscount") ?:""
          val response = fmP10KEN.command51Variant0Version1(subTotalWithPercentDiscount)
          result.success(response.toString())
        }

        "command109Variant0Version0"->{
          val value: String? = call.argument("value")
          val response = fmP10KEN.command109Variant0Version0(value)
          result.success(response.toString())
        }

        "totalInCash"->{
          val response =fmP10KEN.totalInCash()
          result.success(response.toString())
        }

        "generateZ"->{

            Utils.generateZReport(fmP10KEN)
            result.success(true)

        }

        "closeFiscalCheck"->{
         val response =  fmP10KEN.closeFiscalCheck()
          result.success(response.toString())
        }

        "checkAndResolve"->{
          try {
            val response =fmP10KEN.checkAndResolve()
            result.success(response.toString())
          } catch (e: IOException) {
            Toast.makeText(this, "Failed to resolve printer", Toast.LENGTH_LONG).show()
          }
        }

        "command120Variant1Version0"->{
          var response: FiscalResponse? = null
          try {
            response = fmP10KEN.command120Variant1Version0()
            result.success(response.toString())
          } catch (e: IOException) {
            Toast.makeText(this, "Failed to print Z report", Toast.LENGTH_LONG).show()
          }
          }

        "close"->{
          val response = fmP10KEN.close()
          result.success(response.toString())
        }
        }
      }
    }
  }



