import 'package:assessment_software_senai/src/modal/modal_forms_sub_criterion.dart';
import 'package:assessment_software_senai/src/models/new_subcriterion.dart';
import 'package:assessment_software_senai/src/services/sub_criteria_service.dart';
import 'package:assessment_software_senai/src/utils/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListPageSubcriterion extends StatefulWidget {
  final User user;
  final String? criterionId;

  const ListPageSubcriterion({super.key, required this.user, this.criterionId});

  @override
  State<ListPageSubcriterion> createState() => _ListPageSubcriterionState();
}

class _ListPageSubcriterionState extends State<ListPageSubcriterion> {
  final SubCriterionService _subCriterionService = SubCriterionService();

  User get user => widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Subcriterios'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: AppDrawer(user: widget.user),
      body: StreamBuilder(
        stream: _subCriterionService.conectStreamSubcriterion(
          criterionId: widget.criterionId ?? '', // Agora garantido não nulo
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              List<SubCriterion> listaSubcriterion = [];

              for (var doc in snapshot.data!.docs) {
                listaSubcriterion.add(SubCriterion.fromMap(doc.data()));
              }

              return ListView.builder(
                itemCount: listaSubcriterion.length,
                itemBuilder: (context, index) {
                  final subCriterion = listaSubcriterion[index];
                  return ListTile(
                    title: Text(subCriterion.name),
                    subtitle: Text(
                      'Id: ${subCriterion.id}\n'
                      'Descrição: ${subCriterion.description}\n'
                      'Usuário: ${widget.user.email}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => FormsSubCriterion(
                                subCriterion: subCriterion,
                                criterionId: widget.criterionId,
                              ),
                              backgroundColor: Colors.blue[700],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            SnackBar snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Deseja remover ${subCriterion.name} ?',
                              ),
                              action: SnackBarAction(
                                label: 'Remover',
                                textColor: Colors.white,
                                onPressed: () {
                                  _subCriterionService.deleteSubCriterio(
                                    criterionId: widget.criterionId!,
                                    id: subCriterion.id,
                                  );
                                },
                              ),
                            );
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Nenhum SubCriterio cadastrado.',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
