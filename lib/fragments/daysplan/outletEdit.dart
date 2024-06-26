import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eureka/fragments/daysplan/itemForm.dart';
import 'package:eureka/global_helper.dart';
import 'package:eureka/timer.dart';
import 'package:eureka/util/constants.dart' as constants;

class OrderBookingEditPage extends StatefulWidget {
  final int orderId;
  final int outletId;
  const OrderBookingEditPage(
      {super.key, required this.orderId, required this.outletId});

  @override
  _OrderBookingEditPageState createState() => _OrderBookingEditPageState();
}

class _OrderBookingEditPageState extends State<OrderBookingEditPage> {
  bool isExpanded = false;
  bool isDataLoaded = false;
  final globalHelper = GlobalHelper();
  List<Map<String, dynamic>> order = [];
  String total = '0';
  String taxTotal = '0';
  int grossTotal = 0;

  @override
  void initState() {
    super.initState();
    timerController = TimerController(
      duration: Duration(seconds: constants.refTime),
      callback: initializeData,
    )..startPeriodic();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final response =
          await globalHelper.view_order(widget.orderId, widget.outletId);
      if (mounted) {
        setState(() {
          order = List<Map<String, dynamic>>.from(response['order']);
          total = response['total_sum'].toStringAsFixed(2);
          taxTotal = response['gst_amount_sum'].toStringAsFixed(2);
          grossTotal =
              (response['total_sum'] + response['gst_amount_sum']).round();
        });
      }
      isDataLoaded = true;
    } catch (e) {
      print('Error: $e');
    } finally {
      await Future.delayed(Duration(seconds: constants.delayedTime));
    }
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Order Booking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          if (!isDataLoaded)
            Center(child: CircularProgressIndicator())
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  //save funcionality
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        Center(child: CircularProgressIndicator()),
                  );
                  final res = await globalHelper.save_order(widget.orderId);

                  if (res['error'] != null) {
                    constants.Notification(res['error']);
                    Navigator.pop(context);
                  } else if (res['success'] != null) {
                    constants.Notification(res['success']);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Order'),
              ),
            ),
          SizedBox(height: 4.0),
          FutureBuilder(
            future: globalHelper.view_order(widget.orderId, widget.outletId),
            builder: (context, snapshot) {
              order = List<Map<String, dynamic>>.from(
                  snapshot.data?['order'] ?? []);
              var orderItems =
                  order.isNotEmpty ? order[0]['purchaseorder_items'] ?? [] : [];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Order Details Card
                    Card(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                order.isNotEmpty ? order[0]['bill_no'] : ''),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date: ${order.isNotEmpty
                                      ? constants.formatDate(order[0]['bill_date'])
                                      : ''}"),
                                  Text("Total: $total"),
                                  Text("Tax: $taxTotal"),
                                  Text("Gross: $grossTotal"),
                                ]),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  // Handle delete action

                                  // Show a confirmation dialog before proceeding with deletion
                                  bool confirmDelete = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirm Delete'),
                                        content: Text(
                                            'Are you sure you want to delete this order?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              // User clicked "Cancel"
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // User clicked "Delete"
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // Proceed with deletion only if the user confirmed
                                  if (confirmDelete == true) {
                                    var res = await globalHelper
                                        .delete_order(widget.orderId);

                                    if (res['success'] != null) {
                                      constants.Notification(res['success']);
                                    }

                                    // Close the current and previous screens
                                    Navigator.pop(context);
                                  }
                                }),
                          ),

                          SizedBox(height: 8.0),

                          // Expandable Item Details
                          isExpanded
                              ? Column(
                                  children: [
                                    // List of Cards for Item Details
                                    // Replace the placeholder data with your actual item data
                                    if (orderItems.isNotEmpty)
                                      for (int i = 0;
                                          i < orderItems.length;
                                          i++)
                                        ExpansionTile(
                                          title:
                                              Text(orderItems[i]['item_name']),
                                          children: [
                                            ListTile(
                                              title: Text("HSN/SAC: " +
                                                  orderItems[i]['hsn_sac']),
                                            ),
                                            ListTile(
                                              title: Text("Price: " +
                                                  orderItems[i]
                                                      ['taxable_amount']),
                                            ),
                                            ListTile(
                                              title: Text("Quantity: " +
                                                  orderItems[i]['qty']),
                                            ),
                                            ListTile(
                                              title: Text("Gross Total:  $grossTotal"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () async {
                                                    // Handle Edit item tap

                                                    final response =
                                                        await globalHelper
                                                            .get_gst();
                                                    final itemData =
                                                        await globalHelper
                                                            .view_order_item(
                                                                orderItems[i][
                                                                    'order_booking_item_id']);

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        settings: RouteSettings(
                                                            arguments:
                                                                response),
                                                        builder: (context) =>
                                                            AddItemPage(
                                                          itemData:
                                                              itemData, // Pass the list directly
                                                          isEditing: true,
                                                          outletId:
                                                              widget.outletId,
                                                          orderId: order[0][
                                                              'order_booking_id'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () async {
                                                    // Handle delete action

                                                    // Show a confirmation dialog before proceeding with deletion
                                                    bool confirmDelete =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Confirm Delete'),
                                                          content: Text(
                                                              'Are you sure you want to delete this Item?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                // User clicked "Cancel"
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                              child: Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                // User clicked "Delete"
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: Text(
                                                                  'Delete'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                    // Proceed with deletion only if the user confirmed
                                                    if (confirmDelete == true) {
                                                      var res = await globalHelper
                                                          .delete_order_item(
                                                              orderItems[i][
                                                                  'order_booking_item_id']);

                                                      if (res['success'] !=
                                                          null) {
                                                        constants.Notification(
                                                            res['success']);
                                                      }

                                                      // Close the current and previous screens
                                                    }

                                                    // Handle Delete item tap
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  ],
                                )
                              : Container(),
                          // Toggle Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Handle Add Item button tap
          final response = await globalHelper.get_gst();

          Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(arguments: response),
              builder: (context) => AddItemPage(
                  outletId: widget.outletId,
                  orderId: order[0]['order_booking_id']),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderBookingEditPage(
      outletId: 0,
      orderId: 0,
    ),
  ));
}
