import 'package:flutter/material.dart';

class SupportNetworkList extends StatelessWidget {
  const SupportNetworkList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
        thickness: 1,
      ),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            "Username",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: appColors.surface,
            child: Icon(
              Icons.remove_red_eye,
              color: appColors.primary,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: appColors.error,
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
