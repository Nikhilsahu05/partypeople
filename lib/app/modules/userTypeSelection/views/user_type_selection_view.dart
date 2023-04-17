import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

class UserTypeSelectionView extends StatefulWidget {
  const UserTypeSelectionView({super.key});

  @override
  State<UserTypeSelectionView> createState() => _UserTypeSelectionViewState();
}

class _UserTypeSelectionViewState extends State<UserTypeSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: ElevatedButton(
            onPressed: () {},
            child: Center(child: Icon(Icons.arrow_back)),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(CircleBorder()),
              backgroundColor: MaterialStateProperty.all(
                  Color(0xFFd92121)), // <-- Button color
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(1, -0.45),
                radius: 0.9,
                colors: [
                  const Color(0xffd10d0e),
                  const Color(0xff300202),
                ],
                stops: [0.0, 1],
                transform: GradientXDTransform(
                  0.0,
                  -1.0,
                  1.23,
                  0.0,
                  -0.115,
                  1.0,
                  Alignment(0.0, 0.0),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.06,
                      bottom: MediaQuery.of(context).size.height * 0.015,
                    ),
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.05,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.sp)),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(
                      'assets/man.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Text(
                'Individuals',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    bottom: MediaQuery.of(context).size.height * 0.015,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.sp)),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Image.asset(
                    'assets/bulding.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                'Organizations',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ],
          )
        ],
      ),
    );
  }
}
