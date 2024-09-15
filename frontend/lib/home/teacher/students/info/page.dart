import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/home/teacher/students/controller.dart';
import 'package:frontend/home/teacher/students/entities.dart';
import 'package:frontend/util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentInfoPage extends StatelessWidget {
  final Aluno aluno;

  StudentInfoPage({super.key, required this.aluno});

  final _controller = Get.find<StudentsController>();
  final usuarioController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  formatarTelefone(String telefone) {
    if (telefone.length == 11) {
      return telefone.replaceFirstMapped(
        RegExp(r'(\d{2})(\d{5})(\d{4})'),
        (match) => '(${match[1]}) ${match[2]}-${match[3]}',
      );
    } else {
      return telefone.replaceFirstMapped(
        RegExp(r'(\d{2})(\d{4})(\d{4})'),
        (match) => '(${match[1]}) ${match[2]}-${match[3]}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do aluno'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_rounded,
              color: Colors.red,
            ),
            onPressed: () async {
              bool canDelete = await Get.dialog<bool>(
                    AlertDialog(
                      title: const Text('Excluir aluno'),
                      content: const Text('Deseja realmente excluir o aluno?'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('Excluir'),
                        ),
                      ],
                    ),
                  ) ??
                  false;
              if (canDelete) {
                var res = await loading(
                  () => _controller.deleteStudent(aluno.id),
                );

                if (res.isOk) {
                  Get.back();
                  Get.snackbar(
                    'Aluno excluído',
                    'O aluno foi excluído com sucesso',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                  );
                } else {
                  Get.snackbar(
                    'Erro',
                    'Ocorreu um erro ao excluir o aluno',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/profile.png',
                  width: 64,
                  height: 64,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aluno.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Situação: ${aluno.situacao}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 16),
                Text(
                  'Email: ${aluno.email}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 16),
                Text(
                  'Telefone: ${formatarTelefone(aluno.telefone)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 16),
                Text(
                  'Data de nascimento: ${DateFormat('dd/MM/yyyy').format(aluno.dataNascimento)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para criar o acesso do aluno
                    Get.defaultDialog(
                      contentPadding: const EdgeInsets.all(16),
                      title: 'Criar Acesso',
                      content: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: usuarioController,
                          decoration: const InputDecoration(
                            labelText: 'Usuário',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Lógica para criar o acesso do aluno
                            if (formKey.currentState!.validate()) {
                              Get.back();

                              Get.dialog(
                                const Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(24),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircularProgressIndicator(),
                                        Text('Criando acesso...'),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );

                              await Future.delayed(const Duration(seconds: 2));

                              Get.back();

                              Get.defaultDialog(
                                barrierDismissible: false,
                                contentPadding: const EdgeInsets.all(16),
                                onWillPop: () async => false,
                                title: 'Acesso criado',
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Usuário:',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          usuarioController.text,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Senha temporária: ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Text('123456'),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy),
                                          onPressed: () async {
                                            await Clipboard.setData(
                                              const ClipboardData(
                                                text: '123456',
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: const Text(
                            'Criar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                  child: const Text('Criar Acesso'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: aluno.usuario == null
                      ? null
                      : () {
                          Get.defaultDialog(
                            contentPadding: const EdgeInsets.all(16),
                            title: 'Revogar Acesso',
                            content: const Text(
                              'Deseja realmente revogar o acesso?',
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // Lógica para revogar o acesso do aluno
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Revogar Acesso',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Revogar Acesso',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
