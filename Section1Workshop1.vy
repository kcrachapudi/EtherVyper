# pragma version 0.4.1
# @license MIT

my_favorite_number: uint256
job_ID: uint256

@external
def add():
    self.my_favorite_number = self.my_favorite_number + 1

@external
@view
def retrieve()->uint256:
    return self.my_favorite_number

struct Job:
    JobID: uint256
    Position: String[100]
    Employer: String[100]
    Salary:uint256

Jobs: HashMap[uint256, Job]

@external 
def add_Job(position:String[100], employer:String[100], salary:uint256):
    self.job_ID = self.job_ID + 1
    job:Job = Job(JobID=self.job_ID, Position=position, Employer=employer, Salary=salary)
    #Add the in memory job to Jobs on the store
    self.Jobs[self.job_ID] = job

@external
@view
def retrieve_job(job_id:uint256)->Job:
    return self.Jobs[job_id]
