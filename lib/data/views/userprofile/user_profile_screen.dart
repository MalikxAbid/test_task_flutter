import 'package:flutter/material.dart';
import 'package:test_flutter_task/data/widgets/app_color.dart';
import 'package:test_flutter_task/data/widgets/cText.dart';
import 'package:test_flutter_task/data/widgets/c_app_bar.dart';
import 'package:test_flutter_task/data/widgets/reponsive_layout.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CAppBar(
        title: "Mitt konto",
        titleColor: AppColor.black,
      ),
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          _buildProfileCard(context),
          Expanded(child: _buildOptionsList()),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: 'Abid Shoaib',
                fontsize: getResponsiveHeight(context, 14),
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: getResponsiveHeight(context, 5)),
              CText(
                text: 'myname@gmail.com',
                fontsize: getResponsiveHeight(context, 10),
                color: AppColor.white,
              ),
              SizedBox(height: getResponsiveHeight(context, 5)),
              CText(
                text: '07XXXXXXXX',
                fontsize: getResponsiveHeight(context, 10),
                color: AppColor.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList() {
    return ListView(
      children: [
        _buildOptionItem(
          icon: Icons.settings,
          label: 'Kontoinställningar',
          onTap: () {},
        ),
        _buildOptionItem(
          icon: Icons.credit_card,
          label: 'Mina betalmetoder',
          onTap: () {},
        ),
        _buildOptionItem(
          icon: Icons.support_agent,
          label: 'Support',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColor.black),
      title: CText(
        textAlign: TextAlign.start,
        text: label,
        fontsize: 16.0,
        color: AppColor.black,
        fontWeight: FontWeight.w400,
      ),
      onTap: onTap,
    );
  }
}
