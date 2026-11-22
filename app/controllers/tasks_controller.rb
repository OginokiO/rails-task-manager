class TasksController < ApplicationController
  # before_action ejecuta set_task antes de las acciones show, edit, update y destroy,
  # evitando repetir Task.find(params[:id]) en cada una de ellas (principio DRY).
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  # GET /tasks — Muestra el listado de todas las tareas
  def index
    @tasks = Task.all  # Carga todas las tareas de la base de datos usando Active Record
  end

  # GET /tasks/:id — Muestra los detalles de una tarea específica
  def show
    # @task ya está cargado por el before_action :set_task
  end

  # GET /tasks/new — Muestra el formulario para crear una nueva tarea
  def new
    @task = Task.new  # Crea una instancia vacía de Task para el formulario
  end

  # POST /tasks — Recibe el formulario y crea la tarea en la base de datos
  def create
    @task = Task.new(task_params)  # Construye la tarea con los parámetros permitidos

    if @task.save
      redirect_to task_path(@task.id)  # Si se guarda, redirige a la página de detalle
    else
      render :new, status: :unprocessable_entity  # Si falla, vuelve a mostrar el formulario con errores
    end
  end

  # GET /tasks/:id/edit — Muestra el formulario para editar una tarea existente
  def edit
    # @task ya está cargado por el before_action :set_task
  end

  # PATCH /tasks/:id — Recibe el formulario de edición y actualiza la tarea
  def update
    # @task ya está cargado por el before_action :set_task

    if @task.update(task_params)  # Actualiza solo los campos permitidos
      redirect_to task_path(@task.id)  # Si se actualiza, redirige al detalle
    else
      render :edit, status: :unprocessable_entity  # Si falla, vuelve a mostrar el formulario
    end
  end

  # DELETE /tasks/:id — Elimina una tarea de la base de datos
  def destroy
    # @task ya está cargado por el before_action :set_task
    @task.destroy  # Elimina el registro de la base de datos
    redirect_to tasks_path  # Redirige al listado después de eliminar
  end

  private

  # Busca la tarea por ID y la asigna a @task para reutilizarla en múltiples acciones.
  # Esto sigue el principio DRY (Don't Repeat Yourself).
  def set_task
    @task = Task.find(params[:id])
  end

  # Strong Parameters: permite solo los campos que el usuario puede enviar por formulario.
  # Esto evita asignación masiva de atributos no deseados (protección de seguridad).
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
