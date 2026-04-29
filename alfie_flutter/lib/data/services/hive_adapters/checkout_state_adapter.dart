import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:hive/hive.dart';

class CheckoutStateAdapter extends TypeAdapter<CheckoutState> {
  @override
  final int typeId = 20;

  @override
  CheckoutState read(BinaryReader reader) {
    return CheckoutState(
      user: reader.read() as User?,
      deliveryMethod: reader.read() as DeliveryMethod?,
      paymentMethod: reader.read() as PaymentMethod?,
      promoCode: reader.read() as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CheckoutState obj) {
    writer.write(obj.user);
    writer.write(obj.deliveryMethod);
    writer.write(obj.paymentMethod);
    writer.write(obj.promoCode);
  }
}
