import 'package:confeitaria_marketplace/features/confeitaria/bloc/confeitaria_bloc.dart';
import 'package:confeitaria_marketplace/objectbox_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfeitariaListScreen extends StatelessWidget {
  const ConfeitariaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConfeitariaBloc(
        context.read<ObjectBoxStore>(),
      )..add(const ConfeitariaEvent.started()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Confeitarias')),
        body: BlocBuilder<ConfeitariaBloc, ConfeitariaState>(
          builder: (context, state) {
            if (state.isLoading) return const Center(child: CircularProgressIndicator());
            if (state.errorMessage != null) return Center(child: Text('Erro: ${state.errorMessage}'));

            return ListView.builder(
              itemCount: state.confeitarias.length,
              itemBuilder: (context, index) {
                final confeitaria = state.confeitarias[index];
                return ListTile(
                  title: Text(confeitaria.nome),
                  subtitle: Text(confeitaria.telefone),
                  onTap: () {},
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<ConfeitariaBloc>().add(
                        ConfeitariaEvent.deleteConfeitaria(confeitaria.id),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navegar para tela de formulário para adicionar confeitaria
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
