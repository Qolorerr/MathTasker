class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        require_user_logged_in!
        @task = Task.new
        @user_answer = ""
    end

    def show
        @task = Task.find(params[:id])
    end

    def check_user_answer
        require_user_logged_in!
        @task = Task.find(params[:id])
        @user_answer = params[:task][:user_answer]
        @result = ""
        if @task.answer == @user_answer
            task_ids = Current.user.completed_task_ids.split(",")
            already_answered = task_ids.include? @task.id.to_s
            if (!already_answered)
                task_ids << @task.id.to_s
                Current.user.update_attribute(:completed_task_ids, task_ids.join(","))
            end
            @result = "Right answer!"
        else
            @result = "Wrong answer" + @user_answer + "|"
        end
        redirect_to @task, notice: @result
    end

    def edit
        require_user_logged_in!
        @task = Task.find(params[:id])
        access_check
    end

    def update
        require_user_logged_in!
        @task = Task.find(params[:id])
        access_check

        if @task.update(task_params)
            redirect_to @task
        else
            render :edit
        end
    end
    
    def destroy
        require_user_logged_in!
        @task = Task.find(params[:id])
        access_check

        @task.destroy
        redirect_to tasks_path
    end

    def create
        require_user_logged_in!
        @task = Task.new(task_params)
        @task.creator = Current.user
        Current.user.tasks << @task
        @user_answer = ""

        if @task.save
            redirect_to @task
        else
            render :new
        end
    end

    private def task_params
        require_user_logged_in!
        params.require(:task).permit(:title, :body, :answer)
    end

    private def access_check
        redirect_to @task, alert: "You don't have access to this task" if @task.creator != Current.user
    end
end
