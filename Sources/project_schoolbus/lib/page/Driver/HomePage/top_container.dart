import '../../../importer.dart';
import 'light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  EdgeInsets? padding;
  TopContainer({required this.height, required this.width,required this.child, this.padding});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding!=null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.amber,
          ),
      height: height,
      width: width,
      child: child,
    );
  }
}