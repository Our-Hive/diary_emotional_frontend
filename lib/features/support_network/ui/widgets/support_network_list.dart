import 'package:emotional_app/features/support_network/domain/entities/support_network_member.dart';
import 'package:emotional_app/features/support_network/ui/provider/support_network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SupportNetworkList extends ConsumerStatefulWidget {
  const SupportNetworkList({
    super.key,
  });

  @override
  ConsumerState<SupportNetworkList> createState() => _SupportNetworkListState();
}

class _SupportNetworkListState extends ConsumerState<SupportNetworkList> {
  @override
  void initState() {
    ref.read(supportNetworkProvider.notifier).getSupportNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportNetworkProvider);
    return state.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.supportMembers.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final supportMember = state.supportMembers[index];
              return SupportNetworkItemTile(
                member: supportMember,
              );
            },
          );
  }
}

class SupportNetworkItemTile extends ConsumerWidget {
  final SupportNetworkMember member;
  const SupportNetworkItemTile({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).colorScheme;

    return ListTile(
      title: Text(
        member.userName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        member.name,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      // todo: change to inMyNetwork
      leading: member.type == SupportNetworkType.inTheirNetwork
          ? SizedBox()
          : IconButton(
              icon: CircleAvatar(
                backgroundColor: appColors.surface,
                child: Icon(
                  Icons.remove_red_eye,
                  color: appColors.primary,
                ),
              ),
              onPressed: () {},
            ),
      trailing: member.type == SupportNetworkType.inTheirNetwork
          ? SizedBox()
          : IconButton(
              icon: Icon(
                Icons.delete,
                color: appColors.error,
              ),
              onPressed: () {
                ref
                    .read(supportNetworkProvider.notifier)
                    .removeSupportNetworkByUserName(
                      member.userName,
                    );
              },
            ),
    );
  }
}
